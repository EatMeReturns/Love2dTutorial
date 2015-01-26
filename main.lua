function love.load() --game setup: set variables and create data structures and all the other neato things you gotta do to setup.
	circle = {radius = 0, color = {255, 255, 255, 255}, x = 400, y = 300}
	i = 5
end

function love.update() --game state: do pretty much everything that isn't graphics. this is going to be most of your game.
	circle.radius = circle.radius + i
	if math.abs(circle.radius) >= 200 then i = i * -1 end
end

function love.draw() --game rendering: any time you want to render something to the screen, do it here.
	love.graphics.setColor(unpack(circle.color))
	love.graphics.circle('fill', circle.x, circle.y, math.abs(circle.radius))
end

function love.mousepressed(...) --an event handler: this function will be called any time a mousepressed event is handled.
	circle.color = {love.math.random() * 255, love.math.random() * 255, love.math.random() * 255, 255}
end

function love.run() --game loop: this is your entry point for the game. You'll be in this function so long as your game is running.
	tick = 0 --the current tick of the game. basically a running timer of the game.
	tickRate = .02 --the fixed time step. the amount of time that passes between calls to update.
	tickDelta = 0 --the amount of time elapsed between the last frame and the current frame.
	love.load(arg)
	delta = 0
	while true do
		love.timer.step()
		delta = love.timer.getDelta()
		tickDelta = tickDelta + delta
		while tickDelta >= tickRate do
			tick = tick + 1
			tickDelta = tickDelta - tickRate
			love.event.pump() --populate the event queue with any events occurring this tick.
			for e, a, b, c, d in love.event.poll() do --trigger each event in the event queue.
				if e == 'quit' then love.quit() return --event handlers: quit the game
				elseif e == 'mousepressed' then love.mousepressed(a, b, c, d) end --event handlers: press a mouse button
			end

			love.update()
		end
		love.graphics.clear() --refresh the rendering
		love.draw()
		love.graphics.present()
		love.timer.sleep(.001) --limit the CPU
	end
end

function love.quit() --game exit: this is your exit point for the game. Game over man, game over! you'll probably just be saving here.
	--nothing to do here... for now~
end