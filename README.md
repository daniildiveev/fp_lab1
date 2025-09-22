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

### [Задача 4](https://projecteuler.net/problem=4)

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

### [Задача 27](https://projecteuler.net/problem=27)

#### **Решение с помощью классической рекурсии**

```haskell
primeRun :: Int -> Int -> Int
primeRun a b = loopRun 0
 where
  loopRun n
    | isPrime (formulaValue a b n) = 1 + loopRun (n + 1)
    | otherwise = 0

largestQuadPrimesRec :: Int
largestQuadPrimesRec = loopA as (0, 0, 0)
 where
  loopA [] best = productFst2 best
  loopA (a : asRest) best = loopA asRest (loopB a bs best)

  loopB _ [] best = best
  loopB a (b : bsRest) best@(_, _, len) =
    let l = primeRun a b
     in if l > len
          then loopB a bsRest (a, b, l)
          else loopB a bsRest best
```

#### **Решение с помощью хвостовой рекурсии**

```haskell
primeRunTail :: Int -> Int -> Int
primeRunTail a b = loopRunTail 0 0
 where
  loopRunTail n acc
    | isPrime (formulaValue a b n) = loopRunTail (n + 1) (acc + 1)
    | otherwise = acc

largestQuadPrimesTail :: Int
largestQuadPrimesTail = loopA as (0, 0, 0)
 where
  loopA [] best = productFst2 best
  loopA (a : asRest) best = loopA asRest (loopB a bs best)

  loopB _ [] best = best
  loopB a (b : bsRest) best@(_, _, len) =
    let l = primeRunTail a b
     in if l > len
          then loopB a bsRest (a, b, l)
          else loopB a bsRest best
```

#### **Решение с помощью модульной генерации**

```haskell
largestQuadPrimesModular :: Int
largestQuadPrimesModular =
  let allRuns = [(a, b, primeRun a b) | a <- as, b <- bs]
      best = maximumBy (comparing (\(_, _, len) -> len)) allRuns
   in productFst2 best
```

#### **Решение с помощью map**

```haskell
largestQuadPrimesMap :: Int
largestQuadPrimesMap =
  let pairs = [(a, b) | a <- as, b <- bs]
      results = map (\(a, b) -> (a, b, primeRun a b)) pairs
      best = maximumBy (comparing (\(_, _, len) -> len)) results
   in productFst2 best
```

#### **Генератор списков**

```haskell
largestQuadPrimesListComp :: Int
largestQuadPrimesListComp =
  let best =
        maximumBy
          (comparing (\(_, _, len) -> len))
          [(a, b, primeRun a b) | a <- as, b <- bs]
   in productFst2 best
```

#### **Бесконечные списки**

```haskell
runLen :: Int -> Int -> Int
runLen a b = length . takeWhile isPrime $ [formulaValue a b n | n <- [0 ..]]

largestQuadPrimesInfinite :: Int
largestQuadPrimesInfinite =
  let triples = [(a, b, runLen a b) | a <- as, b <- bs]
      best = maximumBy (comparing (\(_, _, len) -> len)) triples
   in productFst2 best
```

Все решения можно посмотреть [здесь](/src/Euler/QuadPrimes.hs)

### Дополнительно

Для каждой функции реализованы тесты:

- [4-я задача](/test/Euler/PalProductSpec.hs)
- [27-я задача](/test/Euler/QuadPrimesSpec.hs)

В репозитории настроен CI, который:

- собирает проект
- запускает тесты
- проверяет код через линтер и форматтер
- запускает код python

[Workflow](/.github/workflows/haskell.yml)
[Конфиг cabal](/fp-labs.cabal)

### Вывод

В ходе выполнения задач были продемонстрированы различные подходы к решению на языке Haskell. Использовались такие функциональные концепции как рекурсия, хвостовая рекурсия, работа с бесконечными списками и др. Это позволило наглядно показать выразительность и мощь функционального программирования на примере Haskell.

Все решения прошли тестирование, что подтверждает их корректность
