// 致谢页
#let ack(
  anonymous: false,
  twoside: false,
  // 其他参数
  title: "致　　谢",
  outlined: true,
  body,
) = {
  if not anonymous {
    pagebreak(weak: true, to: if twoside { "odd" })

    [#heading(level: 1, numbering: none, outlined: outlined, title) <no-auto-pagebreak>]

    body
  }
}
