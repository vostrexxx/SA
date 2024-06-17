-- Вызов функции
BEGIN;
SELECT InsertAndFetchData(123, 10, 'Smartphone');

-- Получение данных из первого курсора
FETCH ALL IN "first_ref";

-- Получение данных из второго курсора
FETCH ALL IN "second_ref";

COMMIT;
