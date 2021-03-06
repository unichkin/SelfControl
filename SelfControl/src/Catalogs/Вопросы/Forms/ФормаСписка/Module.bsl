
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьПросмотрПояснения(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПравильныйВариантОтветаПриИзменении(Элемент)
	ПравильныйВариантОтветаПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПояснениеПриИзменении(Элемент)
	НастройкиОформленияКлиентСервер.ОформитьВопрос(Пояснение);
	СохранитьПояснениеНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)

	ТекСтрока = Элемент.ТекущаяСтрока;
	Если ТекВопрос = ТекСтрока Тогда
		Возврат;
	КонецЕсли;
	ТекВопрос = ТекСтрока;
	ПодключитьОбработчикОжидания("СписокПриАктивизацииСтрокиКлиент", 0.1, Истина);

КонецПроцедуры

&НаСервереБезКонтекста
Процедура СписокПриПолученииДанныхНаСервере(ИмяЭлемента, Настройки, Строки)
	СсылкиВопросов = Строки.ПолучитьКлючи();
	ДанныеВопросов = ДанныеДляОтображенияСостоянияВопросов(СсылкиВопросов);
	Для каждого КлючИЗначение Из Строки Цикл
		ВопросСсылка = КлючИЗначение.Ключ;
		СтрокаСписка = КлючИЗначение.Значение;

		ДанныеВопроса = ДанныеВопросов.Получить(ВопросСсылка);
		СтрокаСписка.Данные.СостояниеВопроса = ИндексКартинкиСостояния(ДанныеВопроса);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗагрузитьТесты(Команда)
	Если НЕ ЗначениеЗаполнено(ТекВопрос) Тогда
		ПоказатьПредупреждение(, "Выберите группу, или элемент в группу которого будет выполнена загрузка.");
		Возврат;
	КонецЕсли;

	ГруппаПриемник = ТекущаяГруппаНаСервере(ТекВопрос);
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ГруппаПриемник", ГруппаПриемник);

	ОткрытьФорму("Обработка.ПарсингВопросов.Форма", ПараметрыОткрытия);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПояснение(Команда)

	Если Элементы.ГруппаПояснение.Скрыта() Тогда
		Возврат;
	КонецЕсли;
	ТекДанные = Элементы.Список.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ТекДанные.ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;

	СохранитьПояснениеНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПояснениеТолькоПросмотр(Команда)
	УстановитьПросмотрПояснения(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьВверх(Команда)
	ПереместитьЭлементНаКлиенте("Вверх");
КонецПроцедуры

&НаКлиенте
Процедура ПереместитьВниз(Команда)
	ПереместитьЭлементНаКлиенте("Низ");
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьТестыИзТекущейГруппы(Команда)

	Если НЕ ЗначениеЗаполнено(ТекВопрос) Тогда
		ПоказатьПредупреждение(, "Выберите группу, или элемент из группы которого будут стартованы тесты.");
		Возврат;
	КонецЕсли;

	СессияТестирования = СессияТестированияНаСервере(ТекВопрос);
	ПараметрыОткрытия = Новый Структура("СессияТестирования", СессияТестирования);
	ОткрытьФорму("Обработка.ЗапускТестов.Форма", ПараметрыОткрытия);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Сервис

&НаКлиентеНаСервереБезКонтекста
Процедура СообщитьПользователю(Текст)
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Текст);
КонецПроцедуры

#КонецОбласти

#Область Диалог

#Область НастройкиФормы

&НаКлиенте
Процедура ПереместитьЭлементНаКлиенте(Направление)
	ПереместитьЭлементНаСервере(Направление);
	ОповеститьОбИзменении(ТекВопрос);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьПросмотрПояснения(Форма, Флаг = Неопределено)
	Если Флаг = Неопределено Тогда
		Флаг = НЕ Форма.Элементы.ПояснениеТолькоПросмотр.Пометка;
	КонецЕсли;
	Форма.Элементы.ПояснениеТолькоПросмотр.Пометка = Флаг;
	Форма.Элементы.Пояснение.ТолькоПросмотр = Флаг;
КонецПроцедуры

&НаКлиенте
Процедура СписокПриАктивизацииСтрокиКлиент()
	Если Элементы.ГруппаПояснение.Скрыта() Тогда
		Возврат;
	КонецЕсли;

	ОтобразитьПояснениеНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СостоянияВопросов

// Данные для отображения состояния вопросов.
//
// Параметры:
//  СписокВопросов Список вопросов
//
// Возвращаемое значение:
//  Соответствие Из КлючИЗначение:
//   * Ключ - СправочникСсылка.Вопросы
//   * Значение - см. НовыеДанныеДляОтображенияСостоянияВопроса
//
&НаСервереБезКонтекста
Функция ДанныеДляОтображенияСостоянияВопросов(СписокВопросов)

	Результат = Новый Соответствие();

	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	Вопросы.Ссылка,
		|	Вопросы.ЕстьОтвет,
		|	Вопросы.ЕстьПояснение,
		|	Вопросы.Проработан
		|ИЗ
		|	Справочник.Вопросы КАК Вопросы
		|ГДЕ
		|	Вопросы.Ссылка В (&СписокВопросов)
		|	И НЕ Вопросы.ЭтоГруппа
		|	И НЕ Вопросы.ПометкаУдаления";

	Запрос.УстановитьПараметр("СписокВопросов", СписокВопросов);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		ДанныеВопроса = НовыеДанныеДляОтображенияСостоянияВопроса();
		ЗаполнитьЗначенияСвойств(ДанныеВопроса, Выборка);
		Результат.Вставить(Выборка.Ссылка, ДанныеВопроса);
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Индекс картинки состояния.
//
// Параметры:
//  ДанныеВопроса - см. НовыеДанныеДляОтображенияСостоянияВопроса
//
// Возвращаемое значение:
//  Число - рассчитывается от реквизитов вопроса:
//  	- 4 (воскл. знак) - если не задан правильный ответ
//  	- 3 (листик с таймером) - если есть ответ, но не заполнено пояснение
//  	- 2 (листик)- есть есть ответ и пояснение, но вопрос не проработан
//  	- 1 (ОК)- если вопрос проработан
//  	- 0 (пусто) - для групп и помеченных на удаление
//
&НаСервереБезКонтекста
Функция ИндексКартинкиСостояния(ДанныеВопроса)

	Результат = 0;
	Если ДанныеВопроса <> Неопределено Тогда
		Если ДанныеВопроса.ЕстьОтвет Тогда
			Если ДанныеВопроса.ЕстьПояснение Тогда
				Если ДанныеВопроса.Проработан Тогда
					Результат = 1;
				Иначе
					Результат = 2;
				КонецЕсли;
			Иначе
				Результат = 3;
			КонецЕсли;
		Иначе
			Результат = 4;
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;

КонецФункции

#КонецОбласти

#КонецОбласти

#Область ВызовСервера

&НаСервереБезКонтекста
Функция СессияТестированияНаСервере(Знач ТекВопрос)
	Перем ОтборСсылка;

	ТекГруппа = ТекущаяГруппаНаСервере(ТекВопрос);
	Если ЗначениеЗаполнено(ТекГруппа) Тогда
		ОтборСсылка = Справочники.ОтборыВопросов.НайтиСоздатьОтборПоГруппе(ТекГруппа);
		СессияТестирования = Справочники.СессииТестирования.НайтиПоследнююАктивную(ОтборСсылка);
		Если НЕ ЗначениеЗаполнено(СессияТестирования) Тогда
			СессияТестирования = Справочники.СессииТестирования.НоваяСессия(ОтборСсылка);
		КонецЕсли;
	КонецЕсли;

	Возврат СессияТестирования;
КонецФункции

&НаСервере
Процедура ПереместитьЭлементНаСервере(Направление)
	ПараметрыПеремещения = Новый Структура;
	ПараметрыПеремещения.Вставить("Источник", Элементы.Список);
	ПараметрыПеремещения.Вставить("ОписаниеКоманды", Новый Структура("Идентификатор", Направление));
	ПараметрыПеремещения.Вставить("Результат", Новый Структура("Текст", ""));

	НастройкаПорядкаЭлементов.Подключаемый_ПереместитьЭлемент(ТекВопрос, ПараметрыПеремещения);

	Если ЗначениеЗаполнено(ПараметрыПеремещения.Результат.Текст) Тогда
		СообщитьПользователю(ПараметрыПеремещения.Результат.Текст);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура СохранитьПояснениеНаСервере()
	ОбъектВопроса = ТекВопрос.ПолучитьОбъект();
	ОбъектВопроса.Пояснение = Новый ХранилищеЗначения(Пояснение);
	ОбъектВопроса.Записать();
КонецПроцедуры

&НаСервере
Процедура ОтобразитьПояснениеНаСервере()

	ПравильныйВариантОтвета = 0;
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВопросыОтветы.Ссылка.ЭтоГруппа КАК ЭтоГруппа,
		|	ВопросыОтветы.Ссылка.Пояснение КАК Пояснение,
		|	ВопросыОтветы.НомерСтроки КАК ПравильныйВариантОтвета
		|ИЗ
		|	Справочник.Вопросы.Ответы КАК ВопросыОтветы
		|ГДЕ
		|	ВопросыОтветы.Ссылка = &Ссылка
		|	И ВопросыОтветы.ЭтоВерныйОтвет = ИСТИНА
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	Вопросы.ЭтоГруппа,
		|	Вопросы.Пояснение,
		|	0
		|ИЗ
		|	Справочник.Вопросы КАК Вопросы
		|ГДЕ
		|	Вопросы.Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка", ТекВопрос);
	РезультатЗапроса = Запрос.Выполнить();

	Если РезультатЗапроса.Пустой() Тогда
		ДоступностьЭлементов = Ложь;
	Иначе
		Реквизиты = РезультатЗапроса.Выбрать();
		Реквизиты.Следующий();
		ДоступностьЭлементов = НЕ Реквизиты.ЭтоГруппа;
	КонецЕсли;

	Элементы.ПравильныйВариантОтвета.Доступность = ДоступностьЭлементов;
	Элементы.Пояснение.Доступность = ДоступностьЭлементов;
	Элементы.ПояснениеТолькоПросмотр.Доступность = ДоступностьЭлементов;
	Элементы.СохранитьПояснение.Доступность = ДоступностьЭлементов;

	Если ДоступностьЭлементов Тогда
		Пояснение = Реквизиты.Пояснение.Получить();
		НастройкиОформленияКлиентСервер.ОформитьВопрос(Пояснение);
		ПравильныйВариантОтвета = Реквизиты.ПравильныйВариантОтвета;
	Иначе
		Пояснение.Удалить();
	КонецЕсли;

	УстановитьПросмотрПояснения(ЭтотОбъект, ЗначениеЗаполнено(Пояснение.Элементы));

КонецПроцедуры

&НаСервереБезКонтекста
Функция ТекущаяГруппаНаСервере(Знач ТекВопрос)

	Если ТекВопрос.ЭтоГруппа Тогда
		ГруппаПриемник = ТекВопрос;
	Иначе
		ГруппаПриемник = ТекВопрос.Родитель;
	КонецЕсли;

	Возврат ГруппаПриемник;

КонецФункции

&НаСервере
Процедура ПравильныйВариантОтветаПриИзмененииНаСервере()

	ВерныйОтветУстановлен = Ложь;
	ВопросОбъект = ТекВопрос.ПолучитьОбъект();
	Для каждого СтрокаТаблицы Из ВопросОбъект.Ответы Цикл
		СтрокаТаблицы.ЭтоВерныйОтвет = Ложь;
		Если СтрокаТаблицы.НомерСтроки = ПравильныйВариантОтвета Тогда
			СтрокаТаблицы.ЭтоВерныйОтвет = Истина;
			ВерныйОтветУстановлен = Истина;
		КонецЕсли;
	КонецЦикла;

	Если НЕ ВерныйОтветУстановлен Тогда
		ВызватьИсключение "Проверьте номера ответов, не обнаружен ответ с номером " +
			ПравильныйВариантОтвета;
	КонецЕсли;

	ВопросОбъект.Записать();

КонецПроцедуры

#КонецОбласти

#Область Конструкторы

&НаСервереБезКонтекста
Функция НовыеДанныеДляОтображенияСостоянияВопроса()

	Результат = Новый Структура();
	Результат.Вставить("ЕстьОтвет", Ложь);
	Результат.Вставить("ЕстьПояснение", Ложь);
	Результат.Вставить("Проработан", Ложь);

	Возврат Результат;

КонецФункции

#КонецОбласти

#КонецОбласти
