-----------------------------------------------------------------------------------------
-- Taisei Scott
-- This program displays a math question for the user. 
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)

display.setDefault("background", 0.4, 0.4, 0.8)

--local variables
local questionObj
local correctObj
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectObj
local randomOperator

local totalSeconds = 10
local secondsLeft = 10
local clockText
local countdownTimer

local lives = 3
local life1
local life2
local life3

--local functions
local function AskQuestions()
	randomOperator = math.random(1, 4)
	--generate 2 random numbers
	randomNumber1 = math.random(0, 10)
	print (randomNumber1)
	randomNumber2 = math.random(0, 10)
	print (randomNumber2)

	if (randomOperator == 1) then
		correctAnswer = randomNumber1 + randomNumber2
		print(correctAnswer)
	
		questionObj.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif (randomOperator == 2) then

		if (randomNumber2 > randomNumber1) then
			correctAnswer = randomNumber2 - randomNumber1
			questionObj.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		else
			correctAnswer = randomNumber1 - randomNumber2
			questionObj.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

		end
		print(correctAnswer)

	elseif (randomOperator == 3) then
		correctAnswer = randomNumber1 * randomNumber2
		print(correctAnswer)
	
		questionObj.text = randomNumber1 .. " x " .. randomNumber2 .. " = "

	elseif (randomOperator == 4) then
		correctAnswer = randomNumber1 * randomNumber2
	
		questionObj.text = correctAnswer.. " / " .. randomNumber2 .. " = "
		correctAnswer = randomNumber1

		print(correctAnswer)
	end

end

local function HideCorrect()
	correctObj.isVisible = false
	incorrectObj.isVisible = false
	AskQuestions()
	print (correctObj.isVisible)
end

local function NumericFieldListener( event )
	--user begins editing field
	if (event.phase == "began") then
	
	elseif event.phase == "submitted" then


		--when answer is submitted(enter), set user imput to userAnswer
		userAnswer = tonumber(event.target.text)
		print (userAnswer)

		--clear text
		event.target.text = ""

		--user answer is correct
		if (userAnswer == correctAnswer) then
			correctObj.isVisible = true
			timer.performWithDelay(2000, HideCorrect)
			print (correctObj.isVisible)
		else
			incorrectObj.isVisible = true
			timer.performWithDelay(2000, HideCorrect)
			print (incorrectObj.isVisible)			

		end
	end
end

local function UpdateTime ()
	secondsLeft = secondsLeft - 1
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then
		secondsLeft = totalSeconds
		lives = lives - 1

		if (lives == 2) then
			life3.isVisible = false
		elseif (lives == 1) then
			life2.isVisible = false
		elseif (lives == 0) then
			life1.isVisible = false
		end
	end
end

--calls the timer
local function StartTimer()
	countdownTimer = timer.performWithDelay (1000, UpdateTime, 0)	
end

--objects

--Displays the question
questionObj = display.newText ("", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObj:setTextColor(0.8, 0.2, 0.4)

--Correct text, invisible
correctObj = display.newText("Correct!", questionObj.x, questionObj.y+100, nil, 50)
correctObj:setTextColor(1, 1, 0)
correctObj.isVisible = false
print (correctObj.isVisible)

--incorrect text, invisible
incorrectObj = display.newText("Incorrect!", questionObj.x, questionObj.y+100, nil, 50)
incorrectObj:setTextColor(1, 1, 0)
incorrectObj.isVisible = false
print (incorrectObj.isVisible)

--numeric field
numericField = native.newTextField(display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

numericField:addEventListener("userInput", NumericFieldListener)

life1 = display.newImageRect("Images/soul.png", 150, 150)
life1.x = display.contentWidth*5/8
life1.y = display.contentHeight*1/7

life2 = display.newImageRect("Images/soul.png", 150, 150)
life2.x = display.contentWidth*6/8
life2.y = display.contentHeight*1/7

life3 = display.newImageRect("Images/soul.png", 150, 150)
life3.x = display.contentWidth*7/8
life3.y = display.contentHeight*1/7


--Function Calls

--call the function Ask Question
AskQuestions()