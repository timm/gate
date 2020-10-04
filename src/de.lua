-- vim: ft=lua ts=2 sw=2 et:


def better(i, j):
    c = i._rows.cols
    s1, s2, n = 0, 0, len(c.y) + 0.0001
    for col in c.y:
      x = i.bins[col.pos]
      y = j.bins[col.pos]
      s1 -= math.e**(col.w * (x - y) / n)
      s2 -= math.e**(col.w * (y - x) / n)
    return s1 / n < s2 / n

