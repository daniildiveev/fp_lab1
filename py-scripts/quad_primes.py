def is_prime(x: int) -> bool:
    if x < 2: return False
    if x % 2 == 0: return bool(x == 2)
    d = 3
    while d * d <= x:
        if x % d == 0: return False
        d += 2
    return True

def run_len(a: int, b: int):
    n = 0
    while is_prime(n*n + a*n + b):
        n += 1
    return n

def largest_quad_primes():
    best = (0, 0, 0)
    for b in range(2, 1001):
        if not is_prime(b): continue
        for a in range(-999, 1000):
            if b > 2 and a % 2 == 0:  # keep it odd when b is odd
                continue
            l = run_len(a, b)
            if l > best[0]:
                best = (l, a, b)
    l, a, b = best
    return a * b, a, b, l

print(largest_quad_primes())
