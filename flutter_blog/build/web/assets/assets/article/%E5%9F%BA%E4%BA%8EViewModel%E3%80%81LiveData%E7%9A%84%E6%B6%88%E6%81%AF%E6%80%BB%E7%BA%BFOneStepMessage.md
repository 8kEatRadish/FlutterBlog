

# 基于ViewModel、LiveData的消息总线OneStepMessage

## ViewModel到底是啥

首先看一下Google官方的解释：

> [`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel) 类旨在以注重生命周期的方式存储和管理界面相关的数据。[`ViewModel`](https://developer.android.com/reference/androidx/lifecycle/ViewModel) 类让数据可在发生屏幕旋转等配置更改后继续留存。

> ![viewmodel-lifecycle.png](https://i.loli.net/2021/03/02/kswJajChBY3V6GE.png)
>
> ​                                                                                摘抄自Android开发者网站

**那么ViewModel是如何做到的呢？**

ViewModel 对象存在的时间范围是获取 ViewModel 时传递给 ViewModelProvider 的 Lifecycle。ViewModel 将一直留在内存中，直到限定其存在时间范围的 Lifecycle 永久消失：对于 Activity，是在 Activity 完成时；而对于 Fragment，是在 Fragment 分离时。

**ViewModelProvide、ViewModelStore、ViewModelStoreOwner都是什么？**

首先ViewModelStroeOwner中持有ViewModelStore：

```java
@SuppressWarnings("WeakerAccess")
public interface ViewModelStoreOwner {
    /**
     * Returns owned {@link ViewModelStore}
     *
     * @return a {@code ViewModelStore}
     */
    @NonNull
    ViewModelStore getViewModelStore();
}
```

而ViewModelStore中持有ViewModel映射：

```java
public class ViewModelStore {
  
  	//持有ViewModel的映射
    private final HashMap<String, ViewModel> mMap = new HashMap<>();

    final void put(String key, ViewModel viewModel) {
        ViewModel oldViewModel = mMap.put(key, viewModel);
        if (oldViewModel != null) {
            oldViewModel.onCleared();
        }
    }

    final ViewModel get(String key) {
        return mMap.get(key);
    }

    Set<String> keys() {
        return new HashSet<>(mMap.keySet());
    }

    /**
     *  Clears internal storage and notifies ViewModels that they are no longer used.
     */
    public final void clear() {
        for (ViewModel vm : mMap.values()) {
            vm.clear();
        }
        mMap.clear();
    }
}

```



这里保存ViewModel的HashMap中的key是DEFAULT_KEY+名字的字符串，具体代码在ViewModelProvide.java中：

```java
    private static final String DEFAULT_KEY =
            "androidx.lifecycle.ViewModelProvider.DefaultKey";
		@NonNull
    @MainThread
    public <T extends ViewModel> T get(@NonNull Class<T> modelClass) {
        String canonicalName = modelClass.getCanonicalName();
        if (canonicalName == null) {
            throw new IllegalArgumentException("Local and anonymous classes can not be ViewModels");
        }
        return get(DEFAULT_KEY + ":" + canonicalName, modelClass);
    }
```



每当想要获取一个ViewModel的时候，需要给ViewModelProvide传递一个ViewModelStoreOwner，ViewModelProvide拿到ViewModelStoreOwner中持有的ViewModelStore，然后获取到mMap中的ViewModel。

## LiveData到底是啥

老规矩，首先看看官方怎么说：

> [`LiveData`](https://developer.android.com/reference/androidx/lifecycle/LiveData) 是一种可观察的数据存储器类。与常规的可观察类不同，LiveData 具有生命周期感知能力，意指它遵循其他应用组件（如 Activity、Fragment 或 Service）的生命周期。这种感知能力可确保 LiveData 仅更新处于活跃生命周期状态的应用组件观察者。

**LiveData有什么优势?**

- **确保界面符合数据状态**


  ```java
   @SuppressWarnings("WeakerAccess") /* synthetic access */
      void dispatchingValue(@Nullable ObserverWrapper initiator) {
          if (mDispatchingValue) {
              mDispatchInvalidated = true;
              return;
          }
          mDispatchingValue = true;
          do {
              mDispatchInvalidated = false;
              if (initiator != null) {
                  considerNotify(initiator);
                  initiator = null;
              } else {
                  for (Iterator<Map.Entry<Observer<? super T>, ObserverWrapper>> iterator =
                          mObservers.iteratorWithAdditions(); iterator.hasNext(); ) {
                      considerNotify(iterator.next().getValue());
                      if (mDispatchInvalidated) {
                          break;
                      }
                  }
              }
          } while (mDispatchInvalidated);
          mDispatchingValue = false;
      }
  ```

  遵循观察者模式，当数据发生变化的时候，LiveData会通知Observer对象，可以帮你完成更新页面的操作。

- **不会发生内存泄漏**


  ```java
          @Override
          public void onStateChanged(@NonNull LifecycleOwner source,
                  @NonNull Lifecycle.Event event) {
              Lifecycle.State currentState = mOwner.getLifecycle().getCurrentState();
              if (currentState == DESTROYED) {
                  removeObserver(mObserver);
                  return;
              }
              Lifecycle.State prevState = null;
              while (prevState != currentState) {
                  prevState = currentState;
                  activeStateChanged(shouldBeActive());
                  currentState = mOwner.getLifecycle().getCurrentState();
              }
          }
  ```

  在LiveData中，观察者会绑定到Lifecycle对象，并在其关联的生命周期遭到销毁后进行自我清理。

- **不会因 Activity 停止而导致崩溃**


  ```java
  @SuppressWarnings("unchecked")
      private void considerNotify(ObserverWrapper observer) {
          if (!observer.mActive) {
              return;
          }
          // Check latest state b4 dispatch. Maybe it changed state but we didn't get the event yet.
          //
          // we still first check observer.active to keep it as the entrance for events. So even if
          // the observer moved to an active state, if we've not received that event, we better not
          // notify for a more predictable notification order.
          if (!observer.shouldBeActive()) {
              observer.activeStateChanged(false);
              return;
          }
          if (observer.mLastVersion >= mVersion) {
              return;
          }
          observer.mLastVersion = mVersion;
          observer.mObserver.onChanged((T) mData);
      }
  ```

  如果观察者不在活跃状态，则它不会接到LiveData的事件。

- **不再需要手动处理生命周期** 

  界面组件只是观察相关数据，不会停止或恢复观察。LiveData 将自动管理所有这些操作，因为它在观察时可以感知相关的生命周期状态变化。

- **数据始终保持最新状态**

  观察者生命周期从非活跃状态到活跃状态，或者重新创建都会收到最新版本的数据，LiveData会记录更新版本号。


  ```java
      private abstract class ObserverWrapper {
          final Observer<? super T> mObserver;
          boolean mActive;
          //最后版本号
          int mLastVersion = START_VERSION;
  
          ObserverWrapper(Observer<? super T> observer) {
              mObserver = observer;
          }
  
          abstract boolean shouldBeActive();
  
          boolean isAttachedTo(LifecycleOwner owner) {
              return false;
          }
  
          void detachObserver() {
          }
  
          void activeStateChanged(boolean newActive) {
              if (newActive == mActive) {
                  return;
              }
              // immediately set active state, so we'd never dispatch anything to inactive
              // owner
              mActive = newActive;
              changeActiveCounter(mActive ? 1 : -1);
              if (mActive) {
                  dispatchingValue(this);
              }
          }
      }
  ```

  

## EventBus咋就不好用了

首先，这是个伪命题。不可否认，EventBus是一个好的框架，消息的发布和订阅的思想影响了后来的很多应用很多框架。

![EventBus-Publish-Subscribe.png](https://i.loli.net/2021/03/02/8qD95KIoypTMYQe.png)

但是EventBus也有一些问题：

- 需要注册和注销，有内存泄漏的风险
- 发送消息成指数增长，增加出错的概率
- 定位消息发送位置较复杂
- 每个事件都是一个类，维护较为困难

## 为啥不用美团的LiveDataBus

**[`LiveDataBus`](https://tech.meituan.com/2018/07/26/android-livedatabus.html)是基于LiveData开发的消息总线，可以代替EventBus使用，但是我们为什么不直接使用呢？**

首先Bus理念是消息的中转站，在多人协作，页面复杂的情景下会出现滥用的情况，缺少唯一可信源的约束。

这里的唯一可信源来自于[`《重学Android》`](https://xiaozhuanlan.com/kunminx)博客的说法。

> **“唯一可信源” 的概念主要是针对 “页面间状态同步” 等场景**。
>
> 在 Jetpack MVVM 中，唯一可信源主要指 **表现层或领域层中 LiveData 子类的直接持有者**，例如 ViewModel 等。
>
> LiveData 的 setValue 和 postValue 默认被设计为 protected，也即对于 “状态同步请求” 等场景，允许开发者在开发过程中 “限制 ViewModel/Request 对 Activity/Fragment 暴露的是 **访问权限受限的父类 LiveData**，而不是作为子类的 MultableLiveData”，
>
> 如此来做到，**数据对页面只读、且来源是统一的**，Activity/Fragment 只能基于拿到的数据去赋值给 ViewModel 中与视图绑定的可变状态，也即这些可变的状态，仅限于页面内部使用、**只能作为 “被通知方” 被改变**，对于源头的只读数据，它们无权篡改，如需要新的数据，只能 **单方面** 地向可信源发起请求，然后由可信源 **单方面** 地、统一地分发结果，如此通过实现 “读写分离” 来实现多页面消息同步的一致性

其次在LiveDataBus中所有消息都是全局的，没有区分。在组件化项目中，消息是需要区分的，有的只需要在组建内部使用，有的是全局消息。

## OneStepMessage有什么好处

**OneStepMessage**基于LiveData和ViewModel，所以LiveData的优点它都有(具体源码分析请查看上方LiveData到底是啥)：

- **确保界面符合数据状态**
- **不会发生内存泄漏**
- **不会因 Activity 停止而导致崩溃**
- **不再需要手动处理生命周期** 
- **数据始终保持最新状态**

对比EventBus和LiveDataBus而言，**OneStepMessage**具有的优势有：

- **可以编写模块消息，控制消息作用范围**

  单独模块创建ViewModel可以使消息的范围在一个模块里，在公共模块创建ViewModel可以使消息为全局消息，做到消息可控。

- **业务进行审查逻辑，控制消息发送入口，消息有唯一可信发送源**

  每一个message在创建的时候都要有业务自己传入审查代码，控制消息发送，该message的所有发送都要经过审查，可以确定唯一可信发送源。


  ```java
  class DemoViewModel : ViewModel() {
  
      //添加审查代码，控制唯一可信源，所有消息都可以业务自己控制是否发送
      val message1 = EventLiveData(object : EventLiveData.PostEventReview<String> {
          override fun review(value: String): Boolean {
  
              //TODO 消息发送审查代码，返回true审查通过可以发送，返回false审查不通过不可以发送
  
              return true
          }
      })
      val message2 = EventLiveData(object : EventLiveData.PostEventReview<Bean> {
          override fun review(value: Bean): Boolean {
  
              //TODO 消息发送审查代码，返回true审查通过可以发送，返回false审查不通过不可以发送
  
              return false
          }
      })
  }
  ```

  在EventLiveData.class中：


  ```java
      fun postEventValue(value: T) {
  
          if (!postEventReview.review(value)) {
              "消息审查失败，拒绝发送消息，请检查审查代码以及消息内容".showLogWithPosition(javaClass.simpleName)
              return
          }
  
          "post message : ${value.toString()} ; ".showLogWithPosition(javaClass.simpleName)
  
          super.postValue(Event(value))
      }
  ```

- **基于Jetpack库，无需引入其他三方库**

- **无需注册、注销，减少代码风险**

- **Log定位，每一条消息都可以直接定位到发送代码位置，方便调试**

**下版本改进方向：**

可以参考Okhttp，使用责任链模式来优化审查代码逻辑。

## OneStepMessage具体使用方法

顾名思义，这个框架叫一步消息，所以使用方式也是一步的：

- **创建一个ViewModel来控制是模块消息还是全局消息。**


  ```java
  class DemoViewModel : ViewModel() {
  
      //添加审查代码，控制唯一可信源，所有消息都可以业务自己控制是否发送
      val message1 = EventLiveData(object : EventLiveData.PostEventReview<String> {
          override fun review(value: String): Boolean {
  
              //TODO 消息发送审查代码，返回true审查通过可以发送，返回false审查不通过不可以发送
  
              return true
          }
      })
      val message2 = EventLiveData(object : EventLiveData.PostEventReview<Bean> {
          override fun review(value: Bean): Boolean {
  
              //TODO 消息发送审查代码，返回true审查通过可以发送，返回false审查不通过不可以发送
  
              return false
          }
      })
  }
  ```

- **一行代码发送消息，一行代码订阅消息。**


  ```java
  				findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
              //发送一个消息1
              OSM.with(DemoViewModel::class.java).message1.postEventValue("更改message1了 random = ${(0..100).random()}")
          }
         
          //监听消息1
          OSM.with(DemoViewModel::class.java).message1.observeEvent(this, ViewModelStore()){
              Toast.makeText(this,it,Toast.LENGTH_SHORT).show()
          }
         
  ```

- **针对Java，添加了CallBack优化，提升编写体验。**


  ```java
  				findViewById(R.id.button_second_message1).setOnClickListener(new View.OnClickListener(){
              @Override
              public void onClick(View v) {
                  OSM.Companion.with(DemoViewModel.class).getMessage1().postEventValue("更改message1了 random = " + r.nextInt());
              }
          });
  
          OSM.Companion.with(DemoViewModel.class).getMessage1().observeEvent(this, new ViewModelStore(), new EventLiveData.OnChanged<String>() {
              @Override
              public void onChanged(String value) {
                  showMessage1.setText(value);
              }
          });
  ```

## 注意

- **订阅消息时，不传入ViewModelStore**

  先接收到的会消费消息，导致其他观察者无法收到消息。

- **订阅消息时，传入同一个ViewModelStore**

  先接收到的会消费消息，导致共用同一个ViewModelStore的观察者无法收到消息。

- **订阅消息时，传入不同ViewModelStore**

  单独接收消息，相互不影响。

造成这种情况是因为LiveData有一个问题，就是会发送多个重复消息给观察者，我这边包装处理Observer来防止此类问题：


```java
    /**
     * 事件只能被一个观察者消费
     */
    @MainThread
    fun observeEvent(owner: LifecycleOwner, onChanged: (T) -> Unit): Observer<Event<T>> {
        //拦截下发事件，判断时候需要下发
        val wrapperObserver = Observer<Event<T>>() {
            it.getContentIfNotHandled()?.let { data ->
                onChanged.invoke(data)
            }
        }
        //注册事件
        super.observe(owner, wrapperObserver)
        return wrapperObserver
    }

    /**
     * 事件可以被多个观察者消费，每个观察者只能消费一次
     */
    @MainThread
    fun observeEvent(
            owner: LifecycleOwner,
            viewModelStore: ViewModelStore,
            onChanged: (T) -> Unit
    ): Observer<Event<T>> {
        //拦截下发事件，判断该观察者是否需要下发
        val wrapperObserver = Observer<Event<T>>() {
            it.getContentIfNotHandled(viewModelStore)?.let() { data ->
                onChanged.invoke(data)
            }
        }
        //注册事件
        super.observe(owner, wrapperObserver)
        return wrapperObserver
    }
```

```java
    fun getContentIfNotHandled(): T? {
        return if (hasBeenHandled) {
            null
        } else {
            hasBeenHandled = true
            content
        }
    }

    /**
     * 不同观察者分别记录分发状态
     * 如果该观察者没有下发过则下发数据
     * 否则返回null
     */
    fun getContentIfNotHandled(viewModelStore: ViewModelStore): T? {
        return if (map.contains(viewModelStore)) {
            null
        } else {
            map[viewModelStore] = true
            content
        }
    }
```

