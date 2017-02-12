﻿
// структура соотвествия имени класса индексу его картинки в коллекции
Перем ИндексыКартинокКлассов;
Перем СоответствиеПоказыватьПриНеобходимости;

Перем ПолужирныйШрифт;

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ФОРМЫ

Процедура ПриОткрытии()
	ЭтаФорма.Заголовок = ЭтотОбъект.ЗаголовокФормы();
	
	Объект().НачальнаяИнициализация();
	ДеревоМетаданных_КопияФормы = ДеревоМетаданных;
	
	ЗаполнитьСписокВыбора_РежимПоиска();
	ЗаполнитьСписокВыбора_РежимСоздания();
	
	ВыгружатьСсылку = Истина;
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ТаблицаДанных

Процедура ТаблицаДанныхСсылкаПриИзменении(Элемент)
	ТаблицаДанныхСсылкаПриИзмененииСервер(ЭлементыФормы.ТаблицаДанных.ТекущаяСтрока);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

Процедура КоманднаяПанель1ПодменюСоздатьМакетДанных(Кнопка)
	ПанельИсточников = ЭлементыФормы.ПанельИсточникиДанных;
	Если ПанельИсточников.ТекущаяСтраница = ПанельИсточников.Страницы.СтраницаМетаданные Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоМетаданным(Кнопка);
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.Страницы.СтраницаТаблицаДанных Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных(Кнопка);
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.Страницы.СтраницаПользователиИБ Тогда
		КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ();
	КонецЕсли;
КонецПроцедуры

Процедура КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных(Кнопка)
	Если ПроверитьЗаполнение() Тогда
		НовыйМакет = СоздатьМакетДанныхПоТаблицеДанныхСервер();
	КонецЕсли;
КонецПроцедуры

Процедура КоманднаяПанель1СоздатьМакетДанныхПоМетаданным(Кнопка)
	
	НовыйМакет = СоздатьМакетДанныхПоМетаданнымСервер();
	
КонецПроцедуры

Процедура КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ()
	
	МассивИменПользователей = Новый Массив;
	Для Каждого Строка Из ЭлементыФормы.ПользователиИБ.ВыделенныеСтроки Цикл
		МассивИменПользователей.Добавить(Строка.Имя);
	КонецЦикла;
	НовыйМакет = СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей);
	
КонецПроцедуры

Процедура КоманднаяПанель1ПротестироватьЗагрузкуМакета(Кнопка)
	Макет = Новый ТабличныйДокумент;
	Макет.Вывести(ЭлементыФормы.Макет);
	
	ПроверитьЗагрузкуМакетаСервер(Макет);
КонецПроцедуры

Процедура КоманднаяПанель1СохранитьМакетДанныхВФайл(Кнопка)
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.ПолноеИмяФайла = "";
	ДиалогВыбораФайла.Фильтр = "Табличный документ (*.mxl)|*.mxl|Все файлы (*.*)|*.*";
	ДиалогВыбораФайла.Заголовок = "Выберите файл";
	Если Не ДиалогВыбораФайла.Выбрать() Тогда
		Возврат;
	КонецЕсли;
	
	Макет = ЭлементыФормы.Макет;
	Макет.Записать(ДиалогВыбораФайла.ПолноеИмяФайла);
КонецПроцедуры

Процедура КоманднаяПанель2ОчиститьТаблицуДанных(Кнопка)
	ТаблицаДанных.Очистить();
КонецПроцедуры

Процедура КоманднаяПанельМакетОчиститьТаблицуДанных(Кнопка)
	ЭлементыФормы.Макет.Очистить();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Функция Объект()
	Возврат ЭтотОбъект;
КонецФункции

Процедура ТаблицаДанныхСсылкаПриИзмененииСервер(ИдентификаторСтрокиДанных)
	ЭлементДанных = ИдентификаторСтрокиДанных;
	Объект().ПриИзмененииСсылки(ЭлементДанных);
КонецПроцедуры

Функция СоздатьМакетДанныхПоТаблицеДанныхСервер()
	Возврат Объект().СоздатьМакетДанныхПоТаблицеДанных(ЭлементыФормы.Макет);
КонецФункции

Функция СоздатьМакетДанныхПоМетаданнымСервер()
	Возврат Объект().СоздатьМакетДанныхПоМетаданным(ЭлементыФормы.Макет);
КонецФункции

Функция СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей)
	Возврат Объект().СоздатьМакетДанныхПоПользователямИБ(ЭлементыФормы.Макет, МассивИменПользователей);
КонецФункции

Процедура ПроверитьЗагрузкуМакетаСервер(ТабличныйДокумент)
	Объект().ПроверитьЗагрузкуМакета(ТабличныйДокумент);
КонецПроцедуры





// Обработчик события ПриВыводеСтроки элемента формы ДеревоМетаданных.
//
Процедура ДеревоМетаданныхПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	
	ОформлениеСтроки.Ячейки.ВыгружатьПриНеобходимости.ОтображатьФлажок = ПоказыватьФлажокВыгружатьПриНеобходимости(ДанныеСтроки);
	ИндексКартинки = Неопределено;
	
	Если ДанныеСтроки.ЭлементОписания <> Неопределено Тогда
		ИндексКартинки = ИндексыКартинокКлассов[ДанныеСтроки.ЭлементОписания.Класс];
	Иначе
		ИндексКартинки = ИндексыКартинокКлассов[ДанныеСтроки.Метаданные];
	КонецЕсли;
	
	Если ИндексКартинки <> Неопределено Тогда
		
		ОформлениеСтроки.Ячейки.Метаданные.ИндексКартинки = ИндексКартинки;
		ОформлениеСтроки.Ячейки.Метаданные.ОтображатьКартинку = Истина;
		
	КонецЕсли;
	
	Если ДанныеСтроки.Использоватьотбор = Истина Тогда
		
		ОформлениеСтроки.Шрифт = ПолужирныйШрифт;
		
	КонецЕсли;
	
КонецПроцедуры

// Функция определяет, следует ли показывать флажок в колонке выгрузки по ссылке
//
// Параметры
//
Функция ПоказыватьФлажокВыгружатьПриНеобходимости(ЭлементДЗ)
	
	ЗапомненноеСостояние = СоответствиеПоказыватьПриНеобходимости[ЭлементДЗ];
	Если ЗапомненноеСостояние <> Неопределено Тогда 
		Возврат ЗапомненноеСостояние;
	КонецЕсли;
	Если ОбъектОбразуетСсылочныйТип(ЭлементДЗ.ОбъектМД) Тогда
		СоответствиеПоказыватьПриНеобходимости[ЭлементДЗ] = Истина;
		Возврат Истина;
	КонецЕсли;
	Для Каждого ПодчиненныйЭлементДЗ Из ЭлементДЗ.Строки Цикл
		Если ПоказыватьФлажокВыгружатьПриНеобходимости(ПодчиненныйЭлементДЗ) Тогда
			СоответствиеПоказыватьПриНеобходимости[ЭлементДЗ] = Истина;
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	СоответствиеПоказыватьПриНеобходимости[ЭлементДЗ] = Ложь;
	Возврат Ложь;
	
КонецФункции

// Обработчик события ПриИзмененииФлажка элемента формы ДеревоМетаданных.
//
Процедура ДеревоМетаданныхПриИзмененииФлажка(Элемент, Колонка)
	Если Колонка = ЭлементыФормы.ДеревоМетаданных.Колонки.Метаданные Тогда
		ОбработкаИзмененияСостоянияВыгружать(Элемент.ТекущиеДанные);
		СоставВыгрузки(Истина);
	ИначеЕсли Колонка = ЭлементыФормы.ДеревоМетаданных.Колонки.ВыгружатьПриНеобходимости Тогда
		ОбработкаИзмененияСостоянияВыгружатьПриНеобходимости(Элемент.ТекущиеДанные);
	КонецЕсли;
КонецПроцедуры

Процедура ДеревоМетаданныхПриАктивизацииСтроки(Элемент)
	
	НастроитьКомпоновщик();
	
КонецПроцедуры

// Служит для настройки построителя при отборе данных
//
// Параметры:
//
Процедура НастроитьКомпоновщик()
	
	ТекущаяСтрока = ЭлементыФормы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ОпределитьПоСтрокеДереваДоступенПостроитель(ТекущаяСтрока) Тогда
		
		ДоступностьКомпоновщика = ЛОЖЬ;
		УдалитьОтборыКомпоновщика(КомпоновщикНастроекКомпоновкиДанных);
		
	Иначе
		
		Попытка
			
			СхемаКомпоновкиДанных = ПодготовитьКомпоновщикДляВыгрузки(ТекущаяСтрока);
			КомпоновщикНастроекКомпоновкиДанных.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных));
			КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
			
			ДоступностьКомпоновщика = Истина;
			
		Исключение
			ДоступностьКомпоновщика = ЛОЖЬ;
			УдалитьОтборыКомпоновщика(КомпоновщикНастроекКомпоновкиДанных);
		КонецПопытки;
		
	КонецЕсли;
	
	ЭлементыФормы.КомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	ЭлементыФормы.КоманднаяПанельКомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	
КонецПроцедуры

Функция ОпределитьПоСтрокеДереваДоступенПостроитель(СтрокаДерева)
	
	Если СтрокаДерева.Строки.Количество() > 0 Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

Процедура УдалитьОтборыКомпоновщика(Компоновщик)
	
	Компоновщик.Настройки.Отбор.Элементы.Очистить();
	
КонецПроцедуры

Процедура КомпоновщикОтборПослеУдаления(Элемент)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

Процедура КомпоновщикОтборПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

Процедура ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки()
	
	ТекущаяСтрока = ЭлементыФормы.ДеревоМетаданных.ТекущиеДанные;
	Если КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор.Элементы.Количество() > 0 Тогда
		
		ТекущаяСтрока.НастройкиКомпоновщика = КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор; //КомпоновщикНастроекКомпоновкиДанных.ПолучитьНастройки();
		ТекущаяСтрока.ИспользоватьОтбор    = ИСТИНА;
		ТекущаяСтрока.Выгружать = Истина;
		
	Иначе
		
		ТекущаяСтрока.НастройкиКомпоновщика = Неопределено;
		ТекущаяСтрока.ИспользоватьОтбор    = ЛОЖЬ;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура КоманднаяПанельКомпоновщикОтборПоказатьРезультатаОтбора(Кнопка)
	
	// показать выбранные записи
	Если ЭлементыФормы.КомпоновщикОтбор.Доступность <> Истина
		ИЛИ ЭлементыФормы.ДеревоМетаданных.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Отчет = СформироватьОтчетПоОтобраннымДанным(ЭлементыФормы.ДеревоМетаданных.ТекущиеДанные);
	Отчет.Показать(НСтр("ru = 'Выбранные объекты'"));
	
КонецПроцедуры

// Обработчик события кнопки ПересчетВыгружаемыхПоСсылке командной панели КоманднаяПанель1.
//
Процедура КоманднаяПанель1ПересчетВыгружаемыхПоСсылке(Кнопка)
	
	СоставВыгрузки(Истина);
	
КонецПроцедуры

Процедура КоманднаяПанельДеревоМетаданныхЗаполнитьТаблицуДанных(Кнопка)
	
	
	
КонецПроцедуры

Процедура ЗаполнитьСписокВыбора_РежимПоиска()
	СписокВыбора_РежимПоиска(ЭлементыФормы.ТаблицаДанных.Колонки.РежимПоиска.ЭлементУправления.СписокВыбора);
КонецПроцедуры

Процедура ЗаполнитьСписокВыбора_РежимСоздания()
	СписокВыбора_РежимСоздания(ЭлементыФормы.ТаблицаДанных.Колонки.РежимСоздания.ЭлементУправления.СписокВыбора);
КонецПроцедуры

Процедура КнопкаУстановкиПериодаНажатие(Элемент)
	НастройкаПериода = Новый НастройкаПериода;
	НастройкаПериода.РедактироватьКакИнтервал = Истина;
	НастройкаПериода.РедактироватьКакПериод = Истина;
	НастройкаПериода.ВариантНастройки = ВариантНастройкиПериода.Период;
	НастройкаПериода.УстановитьПериод(ДатаНачала, ДатаОкончания);
	Если НастройкаПериода.Редактировать() Тогда
		ДатаНачала = НастройкаПериода.ПолучитьДатуНачала();
		ДатаОкончания = НастройкаПериода.ПолучитьДатуОкончания();
	КонецЕсли;	
КонецПроцедуры

Процедура УровеньВыгрузкиПриИзменении(Элемент)
	Если УровеньВыгрузки = 0 Тогда
		СтрокаКонфигурации = ДеревоМетаданных.Строки[0];
		СтрокаКонфигурации.ВыгружатьПриНеобходимости = 1;
		ОбработкаИзмененияСостоянияВыгружатьПриНеобходимости(СтрокаКонфигурации);
	Иначе
		Если Не ЗначениеЗаполнено(СоставПолнойВыгрузки) Тогда
			СоставВыгрузки(Истина);
		Иначе
			ПересчитатьВыгружаемыеПоСсылке(СоставПолнойВыгрузки);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	Отказ = (Вопрос("Вы действительно хотите закрыть обработку?", РежимДиалогаВопрос.ДаНет,,,"Подтвердите выход") = КодВозвратаДиалога.Нет);
КонецПроцедуры


ПолужирныйШрифт = Новый Шрифт(,,ИСТИНА,,,);

ИндексыКартинокКлассов = Новый Структура;
ИндексыКартинокКлассов.Вставить("Справочники",              0);
ИндексыКартинокКлассов.Вставить("ПланыОбмена",              1);
ИндексыКартинокКлассов.Вставить("ПланыСчетов",              2);
ИндексыКартинокКлассов.Вставить("РеквизитыАдресации",       3);
ИндексыКартинокКлассов.Вставить("Константы",                4);
ИндексыКартинокКлассов.Вставить("РегистрыНакопления",       5);
ИндексыКартинокКлассов.Вставить("БизнесПроцессы",           6);
ИндексыКартинокКлассов.Вставить("Последовательности",       7);
ИндексыКартинокКлассов.Вставить("РегистрыСведений",         8);
ИндексыКартинокКлассов.Вставить("Перерасчеты",              9);
ИндексыКартинокКлассов.Вставить("Реквизиты",               10);
ИндексыКартинокКлассов.Вставить("ТабличныеЧасти",          11);
ИндексыКартинокКлассов.Вставить("Ресурсы",                 12);
ИндексыКартинокКлассов.Вставить("ПланыВидовРасчета",       13);
ИндексыКартинокКлассов.Вставить("Документы",               14);
ИндексыКартинокКлассов.Вставить("ПланыВидовХарактеристик", 15);
ИндексыКартинокКлассов.Вставить("Конфигурации",            16);
ИндексыКартинокКлассов.Вставить("Задачи",                  17);
ИндексыКартинокКлассов.Вставить("РегистрыБухгалтерии",     18);
ИндексыКартинокКлассов.Вставить("РегистрыРасчета",         19);
ИндексыКартинокКлассов.Вставить("Измерения",               20);
СоответствиеПоказыватьПриНеобходимости = Новый Соответствие;
