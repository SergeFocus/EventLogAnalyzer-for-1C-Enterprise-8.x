﻿// Осуществляет поиск символа, начиная с конца строки.
//
// Параметры:
//  Строка - Строка - строка, в которой осуществляется поиск;
//  Символ - Строка - искомый символ. Допускается искать строку, содержащую более одного символа.
//
// Возвращаемое значение:
//  Число - позиция символа в строке. 
//          Если строка не содержит указанного символа, то возвращается 0.
//
Функция НайтиСимволСКонца(Знач Строка, Знач Символ) Экспорт
	
	Для Позиция = -СтрДлина(Строка) По -1 Цикл
		Если Сред(Строка, -Позиция, СтрДлина(Символ)) = Символ Тогда
			Возврат -Позиция;
		КонецЕсли;
	КонецЦикла;
	
	Возврат 0;
		
КонецФункции

Процедура СообщитьПользователю(Знач ТекстСообщенияПользователю) Экспорт
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщенияПользователю;
	Сообщение.Сообщить();
КонецПроцедуры


// Раскладывает полное имя файла на составляющие.
//
// Параметры
//  ПолноеИмяФайла – Строка, содержащая полный путь к файлу.
//  ЭтоПапка – Булево, признак того, что требуется разложить полное имя папки, а не файла.
//
// Возвращаемое значение:
//   Структура – имя файла, разложенное на составные части(аналогично свойствам объекта Файл):
//		ПолноеИмя - Содержит полный путь к файлу, т.е. полностью соответствует входному параметру ПолноеИмяФайла.
//		Путь - Содержит путь к каталогу, в котором лежит файл.
//		Имя - Содержит имя файла с расширением, без пути к файлу.
//		Расширение - Содержит расширение файла
//		ИмяБезРасширения - Содержит имя файла без расширения и без пути к файлу.
//			Пример: если ПолноеИмяФайла = "c:\temp\test.txt", то структура заполнится следующим образом:
//				ПолноеИмя: "c:\temp\test.txt"
//				Путь: "c:\temp\"
//				Имя: "test.txt"
//				Расширение: ".txt"
//				ИмяБезРасширения: "test"
//
Функция РазложитьПолноеИмяФайла(Знач ПолноеИмяФайла, ЭтоПапка = Ложь)
	
	СтруктураИмениФайла = Новый Структура("ПолноеИмя,Путь,Имя,Расширение,ИмяБезРасширения");
	
	// Убираем из полного имени файла завершающий слеш и сохраняем получившееся полное имя в структуре
	Если ЭтоПапка И (Прав(ПолноеИмяФайла, 1) = "/" Или Прав(ПолноеИмяФайла, 1) = "\") Тогда
		Если ЭтоПапка Тогда
			ПолноеИмяФайла = Сред(ПолноеИмяФайла, 1, СтрДлина(ПолноеИмяФайла) - 1);
		Иначе
			// Если путь к файлу заканчивается слешем, то у файла нет имени.
			СтруктураИмениФайла.Вставить("ПолноеИмя", ПолноеИмяФайла); 
			СтруктураИмениФайла.Вставить("Путь", ПолноеИмяФайла); 
			СтруктураИмениФайла.Вставить("Имя", ""); 
			СтруктураИмениФайла.Вставить("Расширение", ""); 
			СтруктураИмениФайла.Вставить("ИмяБезРасширения", ""); 
			Возврат СтруктураИмениФайла;
		КонецЕсли;
	КонецЕсли;
	СтруктураИмениФайла.Вставить("ПолноеИмя", ПолноеИмяФайла); 
	
	// Если полное имя файла оказалось пустым, то остальные параметры структуры возвращаем пустыми
	Если СтрДлина(ПолноеИмяФайла) = 0 Тогда 
		СтруктураИмениФайла.Вставить("Путь", ""); 
		СтруктураИмениФайла.Вставить("Имя", ""); 
		СтруктураИмениФайла.Вставить("Расширение", ""); 
		СтруктураИмениФайла.Вставить("ИмяБезРасширения", ""); 
		Возврат СтруктураИмениФайла;
	КонецЕсли;
	
	// Выделяем путь к файлу и имя файла
	Если Найти(ПолноеИмяФайла, "/") > 0 Тогда
		ПозицияРазделителя = НайтиСимволСКонца(ПолноеИмяФайла, "/");
	ИначеЕсли Найти(ПолноеИмяФайла, "\") > 0 Тогда
		ПозицияРазделителя = НайтиСимволСКонца(ПолноеИмяФайла, "\");
	Иначе
		ПозицияРазделителя = 0;
	КонецЕсли;
	СтруктураИмениФайла.Вставить("Путь", Лев(ПолноеИмяФайла, ПозицияРазделителя)); 
	СтруктураИмениФайла.Вставить("Имя", Сред(ПолноеИмяФайла, ПозицияРазделителя + 1));
	
	// Папки не имеют расширений, а для файла выделяем расширение
	Если ЭтоПапка Тогда
		СтруктураИмениФайла.Вставить("Расширение", "");
		СтруктураИмениФайла.Вставить("ИмяБезРасширения", СтруктураИмениФайла.Имя);
	Иначе
        ПозицияТочки = НайтиСимволСКонца(СтруктураИмениФайла.Имя, ".");
		Если ПозицияТочки = 0 Тогда
			СтруктураИмениФайла.Вставить("Расширение", "");
			СтруктураИмениФайла.Вставить("ИмяБезРасширения", СтруктураИмениФайла.Имя);
		Иначе
			СтруктураИмениФайла.Вставить("Расширение", Сред(СтруктураИмениФайла.Имя, ПозицияТочки));
			СтруктураИмениФайла.Вставить("ИмяБезРасширения", Лев(СтруктураИмениФайла.Имя, ПозицияТочки - 1));
		КонецЕсли;
	КонецЕсли;
	
	Возврат СтруктураИмениФайла;
	
КонецФункции

Функция РазложитьСтрокуВМассивПодстрок(Знач Строка, Знач Разделитель = ",", Знач ПропускатьПустыеСтроки = Неопределено)
	
	Результат = Новый Массив;
	
	// для обеспечения обратной совместимости
	Если ПропускатьПустыеСтроки = Неопределено Тогда
		ПропускатьПустыеСтроки = ?(Разделитель = " ", Истина, Ложь);
		Если ПустаяСтрока(Строка) Тогда 
			Если Разделитель = " " Тогда
				Результат.Добавить("");
			КонецЕсли;
			Возврат Результат;
		КонецЕсли;
	КонецЕсли;
	//
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Подстрока) Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если Не ПропускатьПустыеСтроки Или Не ПустаяСтрока(Строка) Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьСтрокуИзМассиваПодстрок(Массив, Разделитель = ",") 
	
	// возвращаемое значение функции
	Результат = "";
	
	Для Каждого Элемент Из Массив Цикл
		
		Подстрока = ?(ТипЗнч(Элемент) = Тип("Строка"), Элемент, Строка(Элемент));
		
		РазделительПодстрок = ?(ПустаяСтрока(Результат), "", Разделитель);
		
		Результат = Результат + РазделительПодстрок + Подстрока;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ВЛог(Стр)
	Лог = Стр + Символы.ВК + Символы.ПС + Лог;
КонецПроцедуры
 

&НаСервере
Процедура ПрочитатьКаталогНаСервере(Знач Каталог = "")
	Если Каталог = "" Тогда
		Каталог = ТекущийКаталог;
	КонецЕсли; 
	сп.Очистить();
	
	массив = НайтиФайлы(Каталог, "*");
	Для Индекс = 0 По массив.Количество() - 1 Цикл
		
		Если ДоступныеРасширения.Количество() > 0
			И НЕ массив[Индекс].ЭтоКаталог()
			И ДоступныеРасширения.НайтиПоЗначению("*" + массив[Индекс].Расширение) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаТЗ = Сп.Добавить();
		СтрокаТЗ.Имя = массив[Индекс].Имя;
		СтрокаТЗ.Путь = массив[Индекс].Путь;
		СтрокаТЗ.ЭтоКаталог = массив[Индекс].ЭтоКаталог();
		Если СтрокаТЗ.ЭтоКаталог Тогда
			СтрокаТЗ.Картинка = БиблиотекаКартинок.ОткрытьФайл;
		Иначе
			СтрокаТЗ.Картинка = БиблиотекаКартинок.Документ;
		КонецЕсли;
		
	КонецЦикла; 
	ТекущийКаталог = Каталог;
	
	Сп.Сортировать("ЭтоКаталог Убыв, Имя Возр");
КонецПроцедуры

&НаКлиенте
Процедура СпВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если Элементы.Сп.ТекущиеДанные.ЭтоКаталог Тогда
		ПрочитатьКаталогНаСервере(ТекущийКаталог + Элементы.Сп.ТекущиеДанные.Имя + "\");
	ИначеЕсли РежимВыбора = "ВыборФайла" Тогда
		Выбрать(Элемент);			
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("РежимВыбора", РежимВыбора);
	
	Если Параметры.Свойство("Заголовок") Тогда
		
		ЭтаФорма.Заголовок = Параметры.Заголовок;
		ЭтаФорма.АвтоЗаголовок = Ложь;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ДоступныеРасширения") Тогда
		МассивДоступныхРасширений = РазложитьСтрокуВМассивПодстрок(Параметры.ДоступныеРасширения, ";", Истина);
		ДоступныеРасширения.ЗагрузитьЗначения(МассивДоступныхРасширений);
	КонецЕсли;
	
	Если Параметры.Свойство("ТекущийКаталог") Тогда
		ТекущийКаталог = Параметры.ТекущийКаталог;
	Иначе
		ТекущийКаталог = "c:\";
	КонецЕсли;
	
	Элементы.СпВыбрать.Видимость = 
		(РежимВыбора = "ВыборФайла");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПолучитьСписокДисковНаСервере();
	ПрочитатьКаталогНаСервере(ТекущийКаталог);
КонецПроцедуры

&НаКлиенте
Процедура Ап(Команда)
	Массив = РазложитьСтрокуВМассивПодстрок(ТекущийКаталог + "1", "\", Ложь);
	Если Массив.Количество() > 2 Тогда
		Массив.Удалить(Массив.Количество() - 1);
		Массив.Удалить(Массив.Количество() - 1);
		ПрочитатьКаталогНаСервере(ПолучитьСтрокуИзМассиваПодстрок(Массив, "\") + "\");
	КонецЕсли; 
КонецПроцедуры

&НаКлиенте
Процедура ТекущийКаталогПриИзменении(Элемент)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаСервере
Процедура ПолучитьСписокДисковНаСервере()
	ServicesSet = ПолучитьCOMОбъект("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2");
	СписокДисков = ServicesSet.ExecQuery("Select Name,VolumeName,VolumeSerialNumber from Win32_LogicalDisk");
	Если СписокДисков.Count>0 Тогда
		Для Каждого Диск Из СписокДисков Цикл
			Попытка
				НоваяКоманда = Команды.Добавить(СтрЗаменить(Диск.Name,":", ""));
				НоваяКоманда.Действие = "ВыбратьДиск";
				НоваяКнопка = Элементы.Добавить("Кнопка" + СтрЗаменить(Диск.Name,":", ""), Тип("КнопкаФормы"), Элементы.СпКоманднаяПанель);
				НоваяКнопка.Заголовок = Диск.Name;
				НоваяКнопка.ИмяКоманды = СтрЗаменить(Диск.Name,":", "");
			Исключение
				СообщитьПользователю(ОписаниеОшибки());
				Продолжить;
			КонецПопытки;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьДиск(Команда)
	ПрочитатьКаталогНаСервере(Команда.Имя + ":\");
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьФайлНаСервер(Команда)
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.МножественныйВыбор = Ложь;
	Если НЕ Диалог.Выбрать() Тогда
		Возврат;
	КонецЕсли;
	ДД = Новый ДвоичныеДанные(Диалог.ПолноеИмяФайла);
	
	СтруктураИмениФайла = РазложитьПолноеИмяФайла(Диалог.ПолноеИмяФайла);
	ЗаписатьФайлНаСерверНаСервере(ДД, Элементы.Сп.ТекущиеДанные.Путь + СтруктураИмениФайла.Имя);
КонецПроцедуры

&НаСервере 
Процедура ЗаписатьФайлНаСерверНаСервере(ДД, ПолноеИмяФайла)
	ДД.Записать(ПолноеИмяФайла);
КонецПроцедуры

&НаКлиенте
Процедура УтащитьФайлССервера(Команда)
	Если Элементы.Сп.ТекущиеДанные.ЭтоКаталог Тогда
		Предупреждение("папки не умею");
		Возврат;
	КонецЕсли;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	Если НЕ Диалог.Выбрать() Тогда
		Возврат;
	КонецЕсли;
	
	АдресХранилища = УтащитьФайлССервераНаСервере(Элементы.Сп.ТекущиеДанные.Путь + Элементы.Сп.ТекущиеДанные.Имя);
	ДД = ПолучитьИзВременногоХранилища(АдресХранилища);
	ДД.Записать(Диалог.Каталог + "\" + Элементы.Сп.ТекущиеДанные.Имя);
КонецПроцедуры

&НаСервереБезКонтекста 
Функция УтащитьФайлССервераНаСервере(ИмяФайла)
	Возврат ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяФайла));
КонецФункции

&НаКлиенте
Процедура УдалитьФайлССервера(Команда)
	Если Элементы.Сп.ТекущиеДанные.ЭтоКаталог Тогда
		Предупреждение("папки не умею");
		Возврат;
	КонецЕсли;
	
	Если Вопрос("Уверен?", РежимДиалогаВопрос.ДаНет) = КодВозвратаДиалога.Да Тогда
		УдалитьФайлССервераНаСервере(Элементы.Сп.ТекущиеДанные.Путь + Элементы.Сп.ТекущиеДанные.Имя);
	КонецЕсли; 
	
	ПрочитатьКаталогНаСервере();
КонецПроцедуры

&НаСервереБезКонтекста 
Процедура УдалитьФайлССервераНаСервере(ИмяФайла)
	УдалитьФайлы(ИмяФайла);	
КонецПроцедуры

&НаКлиенте
Процедура Выбрать(Команда)
	
	ТекДанные = Элементы.Сп.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВыборСделан = Истина;
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Если ВыборСделан Тогда
		
		ТекДанные = Элементы.Сп.ТекущиеДанные;
		Если ТекДанные = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		ВыбранныеДанные = Новый Структура;
		ВыбранныеДанные.Вставить("Имя", ТекДанные.Имя);
		ВыбранныеДанные.Вставить("Путь", ТекДанные.Путь);
		ВыбранныеДанные.Вставить("ЭтоКаталог", ТекДанные.ЭтоКаталог);
		
		ОповеститьОВыборе(ВыбранныеДанные);
		
	КонецЕсли;
	
КонецПроцедуры
