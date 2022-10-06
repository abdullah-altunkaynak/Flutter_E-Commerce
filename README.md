# flutter_ecommerce
<h1> Projenin Amacı </h1>
<p> Bu projede amacım Flutter'da öğrendiğim teknolojileri tecrübe etmek ve test etmek. Bu projede Rest API kullanılarak "https://fakestoreapi.com/" adresinden e-ticaret ile ilgili fake bilgileri çekmek ve göstermektir. API'ye kayıtlı ürünler, kullanıcılar, sepetler vs. bulunmakta. Kullanıcı giriş yapabilir, sepetlerini, profil bilgilerini ve ürünleri kategorilerine göre görebilir. Bu projede MVVM mimarisini kullanarak daha anlaşılır bir kod yazmayı hedefledim. Projede veriler canlı olmadığı için uygulama başlangıcında verileri çekip provider olarak kullandım. Gerçek projede canlı verilerle uğraşırken bu değişiklik gösterebilir. Giriş yapan kullanıcı bilgisini provider içinde saklamam gerekirdi fakat route-args yapısını tecrübe etmek için user nesnesini sayfalar arasında geçiş yaptırdım. </p> 
</br>
<h2> Proje İçerisindeki Yapılar </h2>
<ul> 
    <li>
     <div>
        <h3> Kullanılan Teknolojiler </h3>
            <ul>
                <li>
                Provider
                </li>
                <li>
                Route
                </li>
                <li>
                Rest API - "https://fakestoreapi.com/"
                </li>
                <li>
                MVVM mimarisi
                </li>
                <li>
                Bottom Navigation Bar
                </li>
                <li>
                Page Transition Switcher
                </li>
                <li>
                etc.
                </li>
            </ul>
     </div> 
     </li>
     <li>
        <div>
            <h3> Dosyalar ve İçerikleri </h3>
            <ul>
                <li>
                <p>Model - İçerisinde (cart.dart, products.dart, user.dart) kullanılan verilerin modelleri class biçiminde bulunmakta. </p> 
                </li>
                <li>
                <p>Services - İçerisinde (rest_api.dart) rest api ile web üzerinden verileri çekeceğimiz ve modellere aktaracağımız fonksiyonlar bulunmakta. </p>
                </li>
                <li>
                <p>View - İçerisinde (CategoriesScreen.dart, LetsStartScreen.dart, LoginScreen.dart, MainPageScreen.dart, WelcomeScreen.dart) sayfaların tasarımları bulunmakta ve verilerle ilgili kullanılması gereken fonksiyonlar mümkün olduğunca bu dosyaların dışında kurulmuştur. </p>
                </li>
                <li>
                <p>ViewModel - İçerisinde model-services-view arasındaki köprüyü kuracağımız provider yapısını ve fonksiyonlarını barındırıyor. </p>
                </li>
                <li>
                <p>Assets - içerisinde logoyu barındırıyor ve bu dosyada projede kullanacağımız diğer medyaları vs. tutabiliriz. </p>
                </li>
            </ul>
        </div>
     </li>
</ul>
<h3> Uygulama Çalışır Görüntüsü </h3>
![Gif](https://github.com/abdullah-altunkaynak/Flutter_E-Commerce/blob/master/ezgif.com-gif-maker.gif)
