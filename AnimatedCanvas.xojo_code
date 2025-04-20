#tag Class
Protected Class AnimatedCanvas
Inherits Canvas
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Return me.Enabled
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  '// In this version, we're going to animate color change
		  '   based on whether the mouse is over the control.
		  '   So in MouseEnter we start animating from our
		  '   currentBackgroundColor to our BackgroundColorHover.
		  if me.Enabled then
		    animQueue_Add(new Dictionary("op" : "color", "l" : 250, "t" : Microseconds, "s" : currentBackgroundColor, "e" : mBackgroundColorHover))
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  '// In this version, we're going to animate color change
		  '   based on whether the mouse is over the control.
		  '   So in MouseExit we start animating from our
		  '   currentBackgroundColor to our default BackgroundColor.
		  if me.Enabled then
		    animQueue_Add(new Dictionary("op" : "color", "l" : 250, "t" : Microseconds, "s" : currentBackgroundColor, "e" : mBackgroundColor))
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  '// Just in case we hit some strange scenario where
		  '   the timer is disposed of. Should, theoretically,
		  '   never happen in this case, but better safe than sorry.
		  if IsNull(animTimer) then Return
		  
		  '// Now we're going to check for a currently running
		  '   animation. If an animation operation of this type is
		  '   already underway, all we need to do
		  '   is switch the direction the animation is running.
		  '   In a full animation controller, this would be handled
		  '   internally by chaining or cancelling, most likely,
		  '   but this works for our purposes.
		  if animQueue_IndexOf("width") >= 0 then
		    isExpandedWidth = not isExpandedWidth
		  end if
		  if animQueue_IndexOf("height") >= 0 then
		    isExpandedHeight = not isExpandedHeight
		  end if
		  
		  '// Here we create our dictionary objects containing
		  '   everything our Timer's action event needs to do
		  '   the work. The current time in Microseconds, which
		  '   will be our start time, the start value, and the
		  '   expected result value. This "10" is hard-coded
		  '   just so that we can actually click on the canvas
		  '   again to reverse the animation if it is fully
		  '   collapsed. In most scenarios you wouldn't have
		  '   a hard-coded value like this and you may even be
		  '   triggering the animation from a different element
		  '   altogether, so this value is purely for demonstration
		  '   purposes in this project.
		  '   animQueue_Add is a new method in this part of the
		  '   series, and acts as an animation controller.
		  animQueue_Add(new Dictionary("op" : "width", "l" : manimTime, "m" : mAnimationEasing, "t" : Microseconds, "s" : Width, "e" : If(isExpandedWidth, 10, expandedWidth)))
		  animQueue_Add(new Dictionary("op" : "height", "l" : manimTime, "m" : mAnimationEasing, "t" : Microseconds, "s" : Height, "e" : If(isExpandedHeight, 10, expandedHeight)))
		  
		  '// Finally, enable the timer to perform the animation.
		  animTimer.Mode = 2
		  
		  '// We've added this event, just in case there's
		  '   something you want to trigger at the start of the
		  '   animation.
		  RaiseEvent BeforeAnimate
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  '// In this example, I'm just setting the expandedWidth to the initial width.
		  '   A real-world case would obviously be different.
		  expandedWidth = me.Width
		  expandedHeight = me.Height
		  
		  '// Initialize our animation timer.
		  animTimer = new Timer
		  animTimer.Period = 20
		  animTimer.Mode = 0
		  AddHandler animTimer.Action, WeakAddressOf animTimer_Action
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  '// Just fill it red so that we can see it.
		  g.ForeColor = currentBackgroundColor
		  g.FillRect(0, 0, g.Width, g.Height)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub animQueue_Add(animOp as Dictionary)
		  '// This method is part of our animation controller.
		  '   It appends to or modifies our animation queue,
		  '   which runs concurrent rather than consecutive
		  '   operations.
		  '   We first check to make sure that the new animation
		  '   operation dictionary isn't nil.
		  if IsNull(animOp) then Return
		  
		  '// We need to find out if we already have an operation
		  '   in the queue for this, so we're going to store our
		  '   index in a variable, which we'll get from our new
		  '   anim_IndexOf method.
		  dim foundIndex as Integer = animQueue_IndexOf(animOp.Value("op"))
		  
		  '// If the operation exists, overwrite it. Otherwise,
		  '   append it to our queue so that the timer will
		  '   pick it up on its next Action.
		  if foundIndex >= 0 then
		    
		    '// We're also going to implement what I call Time
		    '   Preservation. I'm sure there another name that
		    '   this is more commonly referred to as, but I
		    '   just don't know it. When PreserveTimes = True
		    '   then the animation operation overwrite will 
		    '   only use the remaining time of the oldest 
		    '   overriden animation operation.
		    if mPreserveTimes then
		      
		      '// Grab the oldest op in our override chain so
		      '   we can perform the math necessary to calculate
		      '   an appropriate time remainder.
		      dim oldOp as Dictionary = animQueue_OldestOp(animQueue(foundIndex))
		      
		      '// Set our animation length to the remaining value.
		      '   We're getting the assigned length of the animation
		      '   and subtracted the difference between our two
		      '   operation start times.
		      animOp.Value("l") = animOp.Value("l") - ((animOp.Value("t").DoubleValue - oldOp.Value("t").DoubleValue) / 1000)
		      
		      '// Set oldOp to our "o" key in case of future overrides.
		      animOp.Value("o") = oldOp
		    end if
		    
		    '// Overwrite the operation.
		    animQueue(foundIndex) = animOp
		  else
		    
		    '// Add the operation to the queue.
		    animQueue.Append(animOp)
		  end if
		  
		  '// Make sure that our animation timer is enabled.
		  animTimer.Mode = 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function animQueue_IndexOf(op as String) As Integer
		  '// This method will check our queue for the
		  '   operation specified in the "op" parameter.
		  '   If it exists, we'll return the index. Otherwise
		  '   we return -1 to denote that this is a new op.
		  
		  '// We're creating our variable before hand so
		  '   we're not doing it in each iteration of the
		  '   loop, which could slow things down a bit.
		  dim currDict as Dictionary
		  
		  '// Likewise, we're creating a variable to store
		  '   the maximum index of our animQueue array. If
		  '   we did this, instead, in the For statement,
		  '   the value would be recalculated each time
		  '   unless something changed that I don't know about.
		  dim intMax as Integer = animQueue.Ubound
		  
		  '// We're starting from the end, just in case
		  '   the contents of the queue change in the middle,
		  '   we're less likely to hit an exception.
		  for intCycle as Integer = intMax DownTo 0
		    '// We're still going to add exception handling
		    '   just in case.
		    Try
		      currDict = animQueue(intCycle)
		    Catch e as OutOfBoundsException
		      Continue
		    End Try
		    
		    '// If our current dictionary's "op" value
		    '   matches the "op" value we're searching for
		    '   then we'll return the index.
		    if currDict.Value("op") = op then
		      Return intCycle
		    end if
		  next
		  
		  '// No matching operation found, so we return -1.
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function animQueue_OldestOp(animOp as Dictionary) As Dictionary
		  if IsNull(animOp) then Return Nil
		  
		  if animOp.HasKey("o") then
		    dim oldOp as Dictionary = animOp.Value("o")
		    while oldOp.HasKey("o")
		      oldOp = oldOp.Value("o")
		    wend
		    
		    Return oldOp
		  end if
		  
		  Return animOp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub animTimer_Action(sender as Timer)
		  '// We're going to declare all of our variables outside of the
		  '   loop so that we're not using precious time and resources
		  '   in every iteration of the loop doing it.
		  dim animOp as Dictionary
		  dim animOpType as String
		  dim animOpEasing as Easings
		  dim animStepDouble as Double
		  dim animStepColor as Color
		  dim animStartTime, timePercent, animLength as Double
		  dim animStartDouble, animEndDouble as Double
		  dim animStartColor, animEndColor, newColor as Color
		  
		  '// Declare our loop maximum variable. Historically each
		  '   iteration of the loop was known to traverse the array
		  '   to get the maximum value if this wasn't stored in advance.
		  '   I haven't tested this myself recently.
		  dim intMax as Integer = animQueue.Ubound
		  
		  '// We start at Ubound and traverse the array in reverse because
		  '   we'll be removing animations from the queue as they complete,
		  '   and this is the best way to avoid OutOfBoundsExceptions.
		  for intCycle as Integer = animQueue.Ubound DownTo 0
		    
		    '// Get our current operation dictionary from the queue.
		    animOp = animQueue(intCycle)
		    
		    '// Our first step is to make sure we actually have an animation
		    '   to perform.
		    if IsNull(animOp) then
		      '// For whatever reason, this entry has been cleared. We'll
		      '   just remove it and continue with the next operation.
		      animQueue.Remove(intCycle)
		      Continue
		    end if
		    
		    '// Now we'll get our operation values from the dictionary object.
		    '   it is possible to run into KeyNotFoundExceptions here, since
		    '   we're not checking first, but if you do, then you've likely
		    '   made an error when modifying the code. No animQueue Dictionary
		    '   should be created without the same set of values since we're
		    '   making use of variant for the values dependiong on the "op"
		    '   kay's value.
		    animOpType = animOp.Value("op").StringValue
		    animStartTime = animOp.Value("t").DoubleValue
		    animLength = animOp.Value("l").DoubleValue
		    
		    '// timePercent is used in the lerp function and gives us a basis
		    '   for dividing up the distance we need to cover in to constituent
		    '   pieces for animating. We also use this for cutting out of the
		    '   animation at the appropriate time. This value ranges from
		    '   0 to 1.0. We subtract our start time from the current time in
		    '   microseconds, then divide by one thousand to convert that in to
		    '   milliseconds. We then divide the result of that by our AnimationTime
		    '   as that's already expressed in milliseconds.
		    timePercent = (((Microseconds - animStartTime) / 1000) / animLength)
		    
		    '// In this part of the series, I show how to animate color changes
		    '   as well as dimensions. This method uses RGB, but you could
		    '   alter lerpColor to use any other method you wish.
		    if animOpType = "color" then
		      '// Get our animation start and end values.
		      animStartColor = animOp.Value("s").ColorValue
		      animEndColor = animOp.Value("e").ColorValue
		      
		      '// Now we're going to pass the necessary parameters in to
		      '   our new lerpColor function to get the current expected
		      '   color at this stage of the animation.
		      animStepColor = lerpColor(animStartColor, animEndColor, timePercent)
		      
		      '// Check to see if this animation operation is complete.
		      '   If so, we remove the operation from the queue and
		      '   move on.
		      if animStepColor = animEndColor or timePercent >= 1 then
		        currentBackgroundColor = animEndColor
		        animQueue.Remove(intCycle)
		        Continue
		      end if
		      
		      '// Assign our lerped color value to the currentBackgroundColor property.
		      currentBackgroundColor = animStepColor
		      
		      '// Since we've now moved our color animation to a place where it
		      '   can be animated without changing the dimensions of the control
		      '   we need to tell the control to update when we set a new color value.
		      Invalidate(False)
		      
		    else
		      '// Get our animation start and end values.
		      animStartDouble = animOp.Value("s").DoubleValue
		      animEndDouble = animOp.Value("e").DoubleValue
		      animOpEasing = animOp.Value("m")
		      
		      '// Here we pass our start value, end value, and the percentage
		      '   of time passed to our lerp function parameters to
		      '   calculate what the current width should be at this point
		      '   in the total animation time. Note that, in our previous
		      '   version, we used a step value and modified our current width
		      '   but in this version our step value is the entire calculated
		      '   current width.
		      animStepDouble = doEasing(animOpEasing, animStartDouble, animEndDouble, timePercent)
		      
		      '// Just do some validation to avoid any issues.
		      if animStepDouble < 0 then animStepDouble = 0
		      
		      '// If we've reached our ending width or our alotted time has
		      '   passed then we bail and set the values we expect at the
		      '   end of the animation.
		      select case animOpType
		      case "width"
		        
		        '// Check to see if this animation operation is complete.
		        '   If so, we remove the operation from the queue and
		        '   move on.
		        if animStepDouble = animEndDouble or timePercent >= 1 then
		          me.Width = animEndDouble ' Set our width to the end result.
		          isExpandedWidth = not isExpandedWidth ' Toggle the state boolean.
		          animQueue.Remove(intCycle)
		          Continue
		        end if
		        
		        '// Apply our new width value.
		        me.Width = animStepDouble
		        
		      case "height"
		        
		        '// Check to see if this animation operation is complete.
		        '   If so, we remove the operation from the queue and
		        '   move on.
		        if animStepDouble = animEndDouble or timePercent >= 1 then
		          me.Height = animEndDouble
		          isExpandedHeight = not isExpandedHeight
		          animQueue.Remove(animQueue.IndexOf(animOp))
		          Continue
		        end if
		        
		        '// Apply our new height value.
		        me.Height = animStepDouble
		        
		      end select
		    end if
		  next
		  
		  '// At this stage, we want to see if there are any animation operations
		  '   that have yet to complete. If everything is done, then we disable
		  '   our timer.
		  if animQueue.Ubound < 0 then
		    sender.Mode = 0
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function doEasing(easing as Easings, startValue as Double, endValue as Double, alphaValue as Double) As Double
		  select case easing
		  case easings.Linear
		    Return lerp( startValue, endValue, alphaValue )
		  case easings.InQuad
		    Return easeInQuad( startValue, endValue, alphaValue )
		  case easings.OutQuad
		    Return easeOutQuad( startValue, endValue, alphaValue )
		  case easings.InOutQuad
		    Return easeInOutQuad( startValue, endValue, alphaValue )
		  case easings.InCubic
		    Return easeInCubic( startValue, endValue, alphaValue )
		  case easings.OutCubic
		    Return easeInOutCubic( startValue, endValue, alphaValue )
		  case easings.InOutCubic
		    Return easeInOutCubic( startValue, endValue, alphaValue )
		  case easings.InElastic
		    Return easeInElastic( startValue, endValue, alphaValue )
		  case easings.OutElastic
		    Return easeOutElastic( startValue, endValue, alphaValue )
		  case easings.InOutElastic
		    Return easeInOutElastic( startValue, endValue, alphaValue )
		  end select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInCubic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  return ((endValue - startValue) * (alphaValue ^ 3)) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInElastic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  Return ((endValue - startValue) * (0.04 * alphaValue / (alphaValue - 1) * Sin( 25 * (alphaValue - 1) ))) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInOutCubic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  dim opChange as Double = Abs(endValue - startValue)
		  
		  if alphaValue <= 0.5 then
		    return easeInCubic(startValue, opChange /  2, alphaValue * 2)
		  else
		    return easeOutCubic(opChange / 2, endValue, Abs(1 - (alphaValue * 2)))
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInOutElastic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  dim opChange as Double = Abs(endValue - startValue)
		  
		  if alphaValue <= 0.5 then
		    return easeInElastic(startValue, opChange /  2, alphaValue * 2)
		  else
		    return easeOutElastic(opChange / 2, endValue, Abs(1 - (alphaValue * 2)))
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInOutQuad(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  dim opChange as Double = Abs(endValue - startValue)
		  
		  if alphaValue <= 0.5 then
		    return easeInQuad(startValue, opChange /  2, alphaValue * 2)
		  else
		    return easeOutQuad(opChange / 2, endValue, Abs(1 - (alphaValue * 2)))
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeInQuad(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  return ((endValue - startValue) * (alphaValue ^ 2)) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeOutCubic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  return ((endValue - startValue) * ((alphaValue - 1) * ((alphaValue - 1) ^ 2) + 1)) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeOutElastic(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  Return ((endValue - startValue) * ((0.04 - 0.04 / alphaValue) * Sin( 25 * alphaValue ) + 1)) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function easeOutQuad(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  return (-(endValue - startValue) * alphaValue) * (alphaValue - 2) + startValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function lerp(startValue as Double, endValue as Double, alphaValue as Double) As Double
		  '// The lerp function evaluates where we should be in the animation
		  '   given a starting point, an ending point, and the amount of time
		  '   elapsed. Lerp is shorthand for linear interpolation.
		  return (startValue * (1 - alphaValue)) + (endValue * alphaValue)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function lerpColor(startColor as Color, endColor as Color, alphaValue as Double) As Color
		  '// This method takes starting and ending color values
		  '   and applies the lerp method for linear interpolation to
		  '   the constituent Red, Green and Blue values to generate
		  '   the new color value based on the animation's elapsed
		  '   time.
		  '   This could be switched from RGB for different effects,
		  '   or you could just use Color.Alpha for making objects
		  '   fade in or out.
		  dim animStepR as Double = Lerp(startColor.Red, endColor.Red, alphaValue)
		  dim animStepG as Double = Lerp(startColor.Green, endColor.Green, alphaValue)
		  dim animStepB as Double = Lerp(startColor.Blue, endColor.Blue, alphaValue)
		  
		  Return RGB(animStepR, animStepG, animStepB)
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AfterAnimate()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeAnimate()
	#tag EndHook


	#tag Note, Name = Easing Function Sources
		Easing functions not written by me were translated using the following sources:
		https://github.com/danro/jquery-easing/blob/master/jquery.easing.js
		https://gist.github.com/gre/1650294
		https://easings.net/
		
	#tag EndNote

	#tag Note, Name = License
		
		MIT License
		
		Copyright (c) 2025 Anthony G. Cyphers
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
	#tag EndNote


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAnimationEasing
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mAnimationEasing = value
			End Set
		#tag EndSetter
		AnimationEasing As Easings
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return manimTime
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  manimTime = value
			  if manimTime < 0 then manimTime = 0
			End Set
		#tag EndSetter
		AnimationTime As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private animQueue() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private animTimer As Timer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mBackgroundColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBackgroundColor = value
			End Set
		#tag EndSetter
		BackgroundColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mBackgroundColorHover
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mBackgroundColorHover = value
			End Set
		#tag EndSetter
		BackgroundColorHover As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private currentBackgroundColor As Color = &cff0000
	#tag EndProperty

	#tag Property, Flags = &h21
		Private expandedHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private expandedWidth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private isExpandedHeight As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private isExpandedWidth As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAnimationEasing As Easings
	#tag EndProperty

	#tag Property, Flags = &h21
		Private manimTime As Integer = 250
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackgroundColor As Color = &cff0000
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBackgroundColorHover As Color = &c0000ff
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreserveTimes As Boolean = True
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPreserveTimes
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mPreserveTimes = value
			End Set
		#tag EndSetter
		PreserveTimes As Boolean
	#tag EndComputedProperty


	#tag Enum, Name = Easings, Type = Integer, Flags = &h0
		Linear
		  InQuad
		  OutQuad
		  InOutQuad
		  InCubic
		  OutCubic
		  InOutCubic
		  InElastic
		  OutElastic
		InOutElastic
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Appearance"
			InitialValue="&cFF0000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColorHover"
			Visible=true
			Group="Appearance"
			InitialValue="&c0000FF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DoubleBuffer"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimationTime"
			Visible=true
			Group="Behavior"
			InitialValue="250"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PreserveTimes"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AnimationEasing"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Easings"
			EditorType="Enum"
			#tag EnumValues
				"0 - Linear"
				"1 - InQuad"
				"2 - OutQuad"
				"3 - InOutQuad"
				"4 - InCubic"
				"5 - OutCubic"
				"6 - InOutCubic"
				"7 - InElastic"
				"8 - OutElastic"
				"9 - InOutElastic"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group=""
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
