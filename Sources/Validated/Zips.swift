public func zip<A, B, C, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>
  )
  -> Validated<(A, B, C), Error> {

    return zip(zip(a, b), c)
      .map { ($0.0, $0.1, $1) }
}

public func zip<A, B, C, D, Error>(
  with f: @escaping (A, B, C) -> D
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>
  )
  -> Validated<D, Error> {

    return { zip($0, $1, $2).map(f) }
}

public func zip<A, B, C, D, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>
  )
  -> Validated<(A, B, C, D), Error> {

    return zip(zip(a, b), c, d)
      .map { ($0.0, $0.1, $1, $2) }
}

public func zip<A, B, C, D, E, Error>(
  with f: @escaping (A, B, C, D) -> E
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>
  )
  -> Validated<E, Error> {

    return { zip($0, $1, $2, $3).map(f) }
}

public func zip<A, B, C, D, E, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>
  )
  -> Validated<(A, B, C, D, E), Error> {

    return zip(zip(a, b), c, d, e)
      .map { ($0.0, $0.1, $1, $2, $3) }
}

public func zip<A, B, C, D, E, F, Error>(
  with f: @escaping (A, B, C, D, E) -> F
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>
  )
  -> Validated<F, Error> {

    return { zip($0, $1, $2, $3, $4).map(f) }
}

public func zip<A, B, C, D, E, F, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>,
  _ f: Validated<F, Error>
  )
  -> Validated<(A, B, C, D, E, F), Error> {

    return zip(zip(a, b), c, d, e, f)
      .map { ($0.0, $0.1, $1, $2, $3, $4) }
}

public func zip<A, B, C, D, E, F, G, Error>(
  with f: @escaping (A, B, C, D, E, F) -> G
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>,
  Validated<F, Error>
  )
  -> Validated<G, Error> {

    return { zip($0, $1, $2, $3, $4, $5).map(f) }
}

public func zip<A, B, C, D, E, F, G, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>,
  _ f: Validated<F, Error>,
  _ g: Validated<G, Error>
  )
  -> Validated<(A, B, C, D, E, F, G), Error> {

    return zip(zip(a, b), c, d, e, f, g)
      .map { ($0.0, $0.1, $1, $2, $3, $4, $5) }
}

public func zip<A, B, C, D, E, F, G, H, Error>(
  with f: @escaping (A, B, C, D, E, F, G) -> H
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>,
  Validated<F, Error>,
  Validated<G, Error>
  )
  -> Validated<H, Error> {

    return { zip($0, $1, $2, $3, $4, $5, $6).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>,
  _ f: Validated<F, Error>,
  _ g: Validated<G, Error>,
  _ h: Validated<H, Error>
  )
  -> Validated<(A, B, C, D, E, F, G, H), Error> {

    return zip(zip(a, b), c, d, e, f, g, h)
      .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6) }
}

public func zip<A, B, C, D, E, F, G, H, I, Error>(
  with f: @escaping (A, B, C, D, E, F, G, H) -> I
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>,
  Validated<F, Error>,
  Validated<G, Error>,
  Validated<H, Error>
  )
  -> Validated<I, Error> {

    return { zip($0, $1, $2, $3, $4, $5, $6, $7).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, I, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>,
  _ f: Validated<F, Error>,
  _ g: Validated<G, Error>,
  _ h: Validated<H, Error>,
  _ i: Validated<I, Error>
  )
  -> Validated<(A, B, C, D, E, F, G, H, I), Error> {

    return zip(zip(a, b), c, d, e, f, g, h, i)
      .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, Error>(
  with f: @escaping (A, B, C, D, E, F, G, H, I) -> J
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>,
  Validated<F, Error>,
  Validated<G, Error>,
  Validated<H, Error>,
  Validated<I, Error>
  )
  -> Validated<J, Error> {

    return { zip($0, $1, $2, $3, $4, $5, $6, $7, $8).map(f) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, Error>(
  _ a: Validated<A, Error>,
  _ b: Validated<B, Error>,
  _ c: Validated<C, Error>,
  _ d: Validated<D, Error>,
  _ e: Validated<E, Error>,
  _ f: Validated<F, Error>,
  _ g: Validated<G, Error>,
  _ h: Validated<H, Error>,
  _ i: Validated<I, Error>,
  _ j: Validated<J, Error>
  )
  -> Validated<(A, B, C, D, E, F, G, H, I, J), Error> {

    return zip(zip(a, b), c, d, e, f, g, h, i, j)
      .map { ($0.0, $0.1, $1, $2, $3, $4, $5, $6, $7, $8) }
}

public func zip<A, B, C, D, E, F, G, H, I, J, K, Error>(
  with f: @escaping (A, B, C, D, E, F, G, H, I, J) -> K
  )
  -> (
  Validated<A, Error>,
  Validated<B, Error>,
  Validated<C, Error>,
  Validated<D, Error>,
  Validated<E, Error>,
  Validated<F, Error>,
  Validated<G, Error>,
  Validated<H, Error>,
  Validated<I, Error>,
  Validated<J, Error>
  )
  -> Validated<K, Error> {

    return { zip($0, $1, $2, $3, $4, $5, $6, $7, $8, $9).map(f) }
}
