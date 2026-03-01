// # Note. Nota.

#import "../packages.typ": drafting
#import "../style/style.typ": font_family_sans

#drafting.set-margin-note-defaults(
  stroke: none,
)

#let color_of_fill_of_notes = oklch(100%, 0, 90deg)
#let paint_of_stroke_of_notes = oklch(80.78%, 0, 0deg)
#let thickness_of_stroke_of_notes = 1.5pt

#let block_of_note(
  stroke: none,
  fill: none,
  prefix: (
    body: none,
    color: none,
  ),
  width: auto,
  it,
) = {
  set text(
    font: font_family_sans,
  )
  set par(first-line-indent: 0pt)
  block(
    breakable: false,
    clip: true,
    fill: fill,
    radius: 6pt,
    stroke: stroke,
    width: width,

    grid(
      rows: 2,

      if (prefix != none) {
        block(
          fill: if (
            prefix.keys().contains("color")
          ) {
            prefix.color
          } else {
            fill.mix(color.luma(95%))
          },
          inset: 6pt,
          stroke: stroke,
          prefix.body,
        )
      },

      block(
        inset: 6pt,
        it,
      ),
    ),
  )
}

#let handle_stroke = stroke_object => {
  let converted_stroke = stroke(stroke_object)
  let paint = converted_stroke.paint
  let thickness = converted_stroke.thickness

  if (paint == auto) {
    paint = paint_of_stroke_of_notes
  }
  if (thickness == auto) {
    thickness = thickness_of_stroke_of_notes
  }

  stroke(
    cap: converted_stroke.cap,
    dash: converted_stroke.dash,
    join: converted_stroke.join,
    miter-limit: converted_stroke.miter-limit,
    paint: paint,
    thickness: thickness,
  )
}

#let default_arguments_of_note = (
  prefix: none,
) => (
  fill: color_of_fill_of_notes,
  rect: (
    fill: none,
    stroke: none,
    width: auto,
    it,
  ) => block_of_note(
    fill: fill,
    prefix: prefix,
    stroke: handle_stroke(stroke),
    width: width,
    it,
  ),
  stroke: stroke(
    paint_of_stroke_of_notes + thickness_of_stroke_of_notes,
  ),
)

#let inline_note = drafting.inline-note.with(..default_arguments_of_note())
#let margin_note = drafting.margin-note.with(..default_arguments_of_note())

#let create_prefixed_inline_note = (prefix: none) => drafting.inline-note.with(
  ..default_arguments_of_note(prefix: prefix),
)
#let create_prefixed_margin_note = (prefix: none) => drafting.margin-note.with(
  ..default_arguments_of_note(prefix: prefix),
)

#let create_prefixed_margin_or_inline_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  if (margin) {
    create_prefixed_margin_note(
      prefix: prefix,
    )(
      ..arguments,
      it,
    )
  } else {
    create_prefixed_inline_note(
      prefix: prefix,
    )(
      ..arguments,
      it,
    )
  }
}

#let note_with_prefix = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  let arguments = (
    ..arguments,
    prefix: prefix,
  )
  create_prefixed_margin_or_inline_note(
    arguments: arguments,
    margin: margin,
    prefix: prefix,
    it,
  )
}

#let prefix_content = (
  prefix: none,
  it,
) => {
  if (prefix != none) {
    (
      body: it + sym.space + sym.at + sym.space + prefix.body,
      color: prefix.color,
    )
  } else {
    (body: it)
  }
}

#let create_status_note = (
  arguments: (:),
  color: color_of_fill_of_notes,
  margin: false,
  prefix_text: text(lang: "en", "NOTE"),
  prefix: none,
  it,
) => {
  let arguments_keys = arguments.keys()
  if (not arguments_keys.contains("fill")) {
    arguments.fill = color
  }
  if (not arguments_keys.contains("stroke")) {
    arguments.stroke = color.darken(15%)
  }
  note_with_prefix(
    arguments: arguments,
    margin: margin,
    prefix: prefix_content(
      prefix: prefix,
      prefix_text,
    ),
    it,
  )
}

#let todo_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  create_status_note(
    arguments: arguments,
    color: oklch(91.95%, 0.117, 93.14deg),
    margin: margin,
    prefix_text: text(lang: "en", "AFAZER"),
    prefix: prefix,
    it,
  )
}

#let progress_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  create_status_note(
    arguments: arguments,
    color: oklch(90.73%, 0.142, 115.79deg),
    margin: margin,
    prefix_text: text(lang: "en", "PROGRESSO"),
    prefix: prefix,
    it,
  )
}

#let done_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  create_status_note(
    arguments: arguments,
    color: oklch(86.01%, 0.133, 160.73deg),
    margin: margin,
    prefix_text: text(lang: "en", "FEITO"),
    prefix: prefix,
    it,
  )
}

#let open_discussion_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  create_status_note(
    arguments: arguments,
    color: oklch(83.99%, 0.084, 247.8deg),
    margin: margin,
    prefix_text: text(lang: "en", "ABERTO"),
    prefix: prefix,
    it,
  )
}

#let closed_discussion_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  create_status_note(
    arguments: arguments,
    color: oklch(79.24%, 0.035, 246.88deg),
    margin: margin,
    prefix_text: text(lang: "en", "FECHADO"),
    prefix: prefix,
    it,
  )
}

#let prefixed_note = (
  arguments: (:),
  margin: false,
  note: note_with_prefix,
  prefix: (
    body: none,
    color: none,
  ),
  it,
) => {
  note(
    arguments: arguments,
    margin: margin,
    prefix: prefix,
    it,
  )
}
