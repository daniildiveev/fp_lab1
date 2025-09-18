def is_pal(x : int):
    return str(x) == str(x)[::-1]

def largest_pal_python():
    best = 0
    for a in range(100, 1000):
        for b in range(100, 1000):
            p = a * b
            if is_pal(p) and p > best:
                best = p
    return best

print(largest_pal_python())
