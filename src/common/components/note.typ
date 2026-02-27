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
  block(
    breakable: false,
    clip: true,
    fill: fill,
    radius: 6pt,
    stroke: stroke,
    width: width,

    // [#it,#prefix],

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

#let prefixed_inline_note = (prefix: none) => drafting.inline-note.with(..default_arguments_of_note(prefix: prefix))
#let prefixed_margin_note = (prefix: none) => drafting.margin-note.with(..default_arguments_of_note(prefix: prefix))

#let create_prefixed_margin_or_inline_note = (
  arguments: (:),
  margin: false,
  prefix: none,
  it,
) => {
  if (margin) {
    prefixed_margin_note(
      prefix: prefix,
    )(
      ..arguments,
      it,
    )
  } else {
    prefixed_inline_note(
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

#let todo_note = (
  margin: false,
  it,
) => {
  let color = oklch(91.95%, 0.117, 93.14deg)
  note_with_prefix(
    arguments: (
      fill: color,
      stroke: color.darken(15%),
    ),
    margin: margin,
    prefix: (body: "TODO"),
    it,
  )
}

#let progress_note = (
  margin: false,
  it,
) => {
  let color = oklch(89.63%, 0.147, 121.76deg)
  note_with_prefix(
    arguments: (
      fill: color,
      stroke: color.darken(15%),
    ),
    margin: margin,
    prefix: (body: "PROG"),
    it,
  )
}

#let done_note = (
  margin: false,
  it,
) => {
  let color = oklch(83.99%, 0.084, 247.8deg)
  note_with_prefix(
    arguments: (
      fill: color,
      stroke: color.darken(15%),
    ),
    margin: margin,
    prefix: (body: "DONE"),
    it,
  )
}

#let note_from_person = (
  author: "author",
  color: none,
  margin: false,
  it,
) => {
  let stroke = stroke(
    paint: color,
  )
  let content = {
    text(
      weight: "bold",
      [#author: ],
    )
    it
  }
  if margin == true {
    margin_note(
      stroke: stroke,
      content,
    )
  } else {
    inline_note(
      stroke: stroke,
      content,
    )
  }
}
