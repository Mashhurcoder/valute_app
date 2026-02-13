<img width="300" height="600" alt="image" src="https://github.com/user-attachments/assets/129a0ff2-ac3a-4b60-a844-e3aa52f49266" />
<img width="300" height="600" alt="image" src="https://github.com/user-attachments/assets/e6b96517-e452-455c-b9b0-9af135464ac4" />
<img width="300" height="600" alt="image" src="https://github.com/user-attachments/assets/4fd4fdb0-6b5a-4d73-9435-c439787fa194" />
<img width="300" height="600" alt="image" src="https://github.com/user-attachments/assets/edfd93e1-443e-43e0-994a-fb011b7bb66b" />








Ushbu ilova real vaqt rejimidagi valyuta kurslarini kuzatish va konvertatsiya qilish uchun mo'ljallangan zamonaviy Flutter ilovasi. Loyiha Clean Architecture va MVI/MVVM patternlariga asoslangan holda qurilgan.

✨ Xususiyatlari
Real vaqt rejimidagi kurslar: Dunyo valyutalarining eng so'nggi kurslarini kuzatish.

Valyuta konvertori: Istalgan summani (masalan, 100$ yoki 50€) bir zumda so'mga yoki boshqa valyutalarga hisoblash.

Tarixiy kurslar: Muayyan sanadagi valyuta kurslarini ko'rish imkoniyati.

Ko'p tillilik (Localization): Ilova 4 xil tilda to'liq ishlaydi:

🇺🇿 O'zbek (Lotin)

🇺🇿 Ўзбек (Кирилл)

🇷🇺 Русский

🇺🇸 English

Sliver UI & Animations: SliverAppBar va maxsus animatsiyalar yordamida yaratilgan chiroyli va interaktiv interfeys.

🛠 Texnik imkoniyatlar (Tech Stack)
Flutter SDK - UI interfeysini yaratish uchun.

Dio - HTTP so'rovlarini (API bilan ishlash) boshqarish uchun.

Flutter BLoC - Ilova holatini (State Management) boshqarish uchun.

MVI/MVVM Pattern - Kodning arxitekturaviy tuzilishi va ma'lumotlar oqimini nazorat qilish uchun.

Localization - Ko'p tilli muhitni qo'llab-quvvatlash uchun.

🏗 Arxitektura va Ma'lumotlar oqimi
Ilova ma'lumotlarni boshqarishda BLoC dan foydalanadi:

Events: Foydalanuvchi harakati (masalan, tilni o'zgartirish yoki summani kiritish).

States: UI-ning hozirgi holati (Loading, Success, Error).

Repository: Dio yordamida API-dan ma'lumotlarni yuklab olish va qayta ishlash.
