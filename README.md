# eval.save

`eval.save` is an R package that supports
simple disk caching of expression evaluations.

Below is an example:

```r
library(eval.save)
eval.save.dir(".save")
```

```
## [1] ".save"
```

```r
f <- function(i) i*i
x <- eval.save(f(3), "f")
```

```
## Wed Apr  5 16:59:57 2017 Evaluating .save/f.rda ...
## Wed Apr  5 16:59:57 2017  done.
```

```r
print(x)
```

```
## [1] 9
```

```r
y <- eval.save(f(4), "g")
```

```
## Wed Apr  5 16:59:57 2017 Evaluating .save/g.rda ...
## Wed Apr  5 16:59:57 2017  done.
```

```r
print(y)
```

```
## [1] 16
```

```r
eval.saved("f")
```

```
## [1] TRUE
```

```r
eval.saved("g")
```

```
## [1] TRUE
```

```r
eval.ret("f")
```

```
## [1] 9
```

```r
eval.ret("g")
```

```
## [1] 16
```

```r
f(5)
```

```
## [1] 25
```

```r
z <- eval.save(f(5), "f")
print(z)
```

```
## [1] 9
```

```r
eval.ret("f")
```

```
## [1] 9
```

```r
eval.saved("h")
```

```
## [1] FALSE
```

```r
z <- eval.save(f(5), "h")
```

```
## Wed Apr  5 16:59:57 2017 Evaluating .save/h.rda ...
## Wed Apr  5 16:59:57 2017  done.
```

```r
print(z)
```

```
## [1] 25
```

```r
eval.ret("h")
```

```
## [1] 25
```
