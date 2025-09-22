# Лабораторная работа №1

---

**Студент:** Дивеев Даниил Андреевич \
**ИСУ:** 368105 \
**Группа:** P3321 \
**Университет:** НИУ ИТМО \
**Факультет:** Программная инженерия и компьютерная техника \
**Курс:** 3-й курс

---

## Отчет

В лабораторной работе представлены решения задач 4 и 27 с сайта Project Euler.
Решения реализованы на языке Haskell.

Для каждой задачи были реализованы следующие решения:

1. Рекурсия (обычная и хвостовая)
2. Модульная реализация
3. Генерация при помощи отображения
4. Генератор списков
5. Бесконечные списки
6. Релизация на языке Python

### Задача 4

#### Условие

A palindromic number reads the same both ways. \
The largest palindrome made from the product of two 2-digit numbers \
is 9009 = 91 \* 99.
Find the largest palindrome made from the product of two 3-digit numbers

#### **Решение с помощью классической рекурсии**

```haskell
largestPalRec :: Int
largestPalRec = go 999 999
 where
  go a b
    | a < 100 = 0
    | b < 100 = go (a - 1) 999
    | isPal p = max p (go a (b - 1))
    | otherwise = go a (b - 1)
   where
    p = a * b
```

#### **Решение с помощью хвостовой рекурсии**

```haskell
largestPalTail :: Int
largestPalTail = go 999 999 0
 where
  go a b best
    | a < 100 = best
    | b < 100 = go (a - 1) 999 best
    | p <= best = go a (b - 1) best
    | isPal p = go a (b - 1) (max best p)
    | otherwise = go a (b - 1) best
   where
    p = a * b
```

#### **Решение с помощью модульной генерации**

```haskell
largestPalModular :: Int
largestPalModular =
  let products = [a * b | a <- [100 .. 999], b <- [100 .. 999]]
      pals = filter isPal products
   in foldr max 0 pals
```

#### **Решение с помощью map**

```haskell
largestPalMap :: Int
largestPalMap =
  let products = [(a, b) | a <- [100 .. 999], b <- [100 .. 999], isPal (a * b)]
   in maximum $ map (uncurry (*)) products
```

#### **Генератор списков**

```haskell
largestPalListComp :: Int
largestPalListComp =
  maximum [a * b | a <- [100 .. 999], b <- [100 .. 999], isPal (a * b)]
```

#### **Бесконечные списки**

```haskell
largestPalInfinite :: Int
largestPalInfinite =
  let as = takeWhile (<= 999) [100 ..]
      bs = takeWhile (<= 999) [100 ..]
   in maximum $ filter isPal [a * b | a <- as, b <- bs]
```

Все решения можно посмотреть [здесь](/src/Euler/PalProduct.hs)
