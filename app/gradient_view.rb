class GradientView < NSView
  def drawRect(rect)
    gradient = NSGradient.alloc.initWithStartingColor(NSColor.redColor, endingColor: NSColor.greenColor)
    gradient.drawInRect(rect, angle: rand(360))
  end
end
