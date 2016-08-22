-- Made with <3 by Una Stankovic
--Ova funkcija je neophodna, ona se izvrsava na samom pocetku i vrsi ucitavanja svih potrebnih elemenata
--random seed se koristi za generisanje random pitanja
function love.load()
  math.randomseed(os.time())
  --postavljanje pozadine i inicijalizacije promenljivih
  love.graphics.setBackgroundColor(85,104,153)
  ucitaj_kviz()
  inicijalizacija()
  letItSnow = initSnowAnimation()
  letItSnow("play")

  --fontovi potrebni za ispis
  font = love.graphics.newFont( 24 )
  font1 = love.graphics.newFont( 18 )
  font2 = love.graphics.newFont( 30 )
  font3 = love.graphics.newFont( 50 )
end
--Ova funkcija je neophodna, ona vrsi osvezavanje igre u odredjenom vremenskom intervalu
function love.update(dt)
  letItSnow("changeCoords")
end
--Ova funkcija je neophodna za iscrtavanje svega sto se nalazi u igri
function love.draw()
  --ispis teksta i podesavanje boja i pozicija
  love.graphics.setColor(255,255,255)
  if(prom == "PocetniMeni") then
	snesko()
	letItSnow("draw")
    ispis("Kviz iz Programskih Paradigmi",170,150,font)
    ispis("Una Stankovic",270,200,font)
    love.graphics.setColor(57,65,95)
    love.graphics.rectangle("fill",300,300,100,50)
    xprav = 300
    yprav = 300
    ispis("Start",330,315,font1)
    start = true
  end
  if(prom == "Kategorije") then
    --buttoni za meni
	letItSnow("draw")
    love.graphics.setColor(57,65,95)
    love.graphics.rectangle("fill",90,400,100,50)
    love.graphics.rectangle("fill",500,400,100,50)
    ispis("Dalje",110,415,font1)
    ispis("Izađi",520,415,font1)
    xprav = 90
    yprav = 400
    xprav1 = 520
    yprav1 = 415
    --buttoni za kategorije
    odabirkategorije()
    ispis("Podrazumevana je osnovna kategorija",0,570,font1)
    izadji = true
    dalje = true
  end
  if(prom == "Pitanja") then
    letItSnow("stop")
	letItSnow("destroy")
   --postavljanje pitanja
    love.graphics.setFont(font2)
    love.graphics.print(kat,200,50)
    love.graphics.setFont(font1)
    love.graphics.printf(pitanje,50,100,650)
   --buttoni za meni
    love.graphics.setColor(57,65,95)
    love.graphics.rectangle("fill",200,400,100,50)
    love.graphics.rectangle("fill",500,400,100,50)
    if(klik == true)then
      preboj("Dalje",230,415,font1)
      klik = false
    else
      ispis("Dalje",230,415,font1)
    end
    ispis("Izađi",530,415,font1)
    izadji = true
    xprav = 200
    yprav = 400
    xprav1 = 500
    yprav1 = 400
    --buttoni za odgovore
    love.graphics.rectangle("fill",50,150,20,20)
    love.graphics.rectangle("fill",50,200,20,20)
    love.graphics.rectangle("fill",50,250,20,20)
    love.graphics.rectangle("fill",50,300,20,20)
    selekcija=true
    if(selektY ~= 0) then
      love.graphics.setColor(0,0,0)
      love.graphics.print("X",50,selektY)
    end
    --ponudjeni odgovori
    love.graphics.setColor(255,255,255)
    love.graphics.print(odg1,90,150)
    love.graphics.print(odg2,90,200)
    love.graphics.print(odg3,90,250)
    love.graphics.print(odg4,90,300)
  end
  if(prom == "Kraj") then
    snesko()
    letItSnow("play")
	letItSnow("draw")
    ispis("REZULTAT",300,100, font2)
    ispis(score,350,200, font3)
    love.graphics.setColor(57,65,95)
    love.graphics.rectangle("fill",400,400,100,50)
    love.graphics.rectangle("fill",200,400,100,50)
    love.graphics.setColor(255,255,255)
    ispis("Izađi",420,415,font1)
    ispis("Ponovo",220,415,font1)
    izadji = true
    ponovo = true
    xprav1 = 400
    yprav1 = 400
  end
end

function ucitaj_kviz()
  putanja = love.filesystem.getSourceBaseDirectory( ) .. "\\lua\\"
  pitanja={}
  bodovi=0
  prom="PocetniMeni"
  fajl = io.open(putanja.."pitanja.txt", "r")
  i=1
  while true do
    linija = fajl:read()
    if linija == nil then break end
    pitanja[i] = {}
    pitanja[i][1] = linija
    pitanja[i][2] = fajl:read()
    pitanja[i][3] = fajl:read()
    pitanja[i][4] = fajl:read()
    pitanja[i][5] = fajl:read()
    pitanja[i][6] = fajl:read()
    pitanja[i][7] = fajl:read()
      i=i+1
  end
  fajl:close()
end

function love.mousepressed(x,y,button,istouch)
  if(button == 1) then
    if(x>xprav and x<xprav+100 and y>yprav and y<yprav+50 and start == true)then
      prom = "Kategorije"
    end
    if(start == true and x>50 and x<250 and y>50 and y<100)then
      kat = "Osnovna pitanja"
    end
     if(start == true and x>50 and x<250 and y>150 and y<200)then
      kat = "Konkurentna paradigma"
    end
     if(start == true and x>50 and x<250 and y>250 and y<300)then
      kat = "Komponentna paradigma"
    end
     if(start == true and x>450 and x<650 and y>50 and y<100)then
      kat = "Logička paradigma"
    end
     if(start == true and x>450 and x<650 and y>150 and y<200)then
      kat = "Funkcionalna paradigma"
    end
     if(start == true and x>450 and x<650 and y>250 and y<300)then
      kat = "Imperativna paradigma"
    end
    if(x>xprav and x<xprav+100 and y>yprav and y<yprav+50 and dalje == true) then
      prom = "Pitanja"
      start = false
      klik = false
      if(uIgri == false) then
        kategorijaPitanja()
        uIgri = true
      else
        provera()
        klik = true
      end
      kviz()
    end
    if(ponovo == true and x>200 and x<300 and y>400 and y<450)then
      love.load()
    end
    if(izadji == true and x>xprav1 and x<xprav1+100 and y>yprav1 and y<yprav1+50) then
      love.event.quit()
    end
    if(selekcija == true) then
      if(x>50 and x<70 and y>150 and y<170) then
        selektY = 150
        odg = 1
      end
      if(x>50 and x<70 and y>200 and y<220) then
        selektY = 200
        odg = 2
      end
      if(x>50 and x<70 and y>250 and y<270) then
        selektY = 250
        odg = 3
      end
      if(x>50 and x<70 and y>300 and y<320) then
        selektY = 300
        odg = 4
      end
    end
  end
end

function kategorijaPitanja()
  pitanja1 = {}
  j=1
  for i = 1,#pitanja do
    if(pitanja[i][7] == kat)then
      pitanja1[j]={}
      pitanja1[j] = pitanja[i]
      j = j + 1
    end
  end
end

function kviz()
  -- math.random(lower, upper) generates integer numbers between lower and upper.
  --biramo redni broj pitanja
  selektY = 0
  br = math.random(1,#pitanja1)
  if(#pitanja1 == 0) then
    kraj()
    return
  end
  pitanje = pitanja1[br][1]
  odg1 = pitanja1[br][2]
  odg2 = pitanja1[br][3]
  odg3 = pitanja1[br][4]
  odg4 = pitanja1[br][5]
end

function provera()
  if(pitanja1[br][odg+1] == pitanja1[br][6]) then
    score = score + 1
  end
  table.remove(pitanja1,br)
  odg = 0
end

function kraj()
  prom = "Kraj"
  selekcija = false
  dalje = false
  uIgri = false
end

function inicijalizacija()
  --ucitavanje pomocnih promenljivih
  start = false
  dalje = false
  izadji = false
  selekcija = false
  uIgri = false
  ponovo = false
  klik = false
  selektY = 0
  odg = 0
  score = 0
  kat = "Osnovna pitanja"
end

--crtanja ispisi i buttoni :)

function ispis(tekst,x,y,font)
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(font)
  love.graphics.print(tekst,x,y)
end

function preboj(tekst,x,y,font)
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(font)
  love.graphics.print(tekst,x,y)
end

function odabirkategorije()
  love.graphics.setFont(font)
  love.graphics.setColor(57,65,95)
  love.graphics.rectangle("fill",50,50,200,50)
  love.graphics.rectangle("fill",50,150,200,50)
  love.graphics.rectangle("fill",50,250,200,50)
  love.graphics.rectangle("fill",450,50,200,50)
  love.graphics.rectangle("fill",450,150,200,50)
  love.graphics.rectangle("fill",450,250,200,50)
  love.graphics.setColor(255,255,255)
  if(kat == "Konkurentna paradigma")then
    preboj("Konkurentna",60,160,font)
  else
    ispis("Konkurentna", 60, 160, font)
  end
  if(kat == "Komponentna paradigma")then
    preboj("Komponentna",60,260,font)
  else
    ispis("Komponentna",60,260, font)
  end
  if(kat == "Logička paradigma")then
    preboj("Logička",460,60,font)
  else
    ispis("Logička",460,60, font)
  end
  if(kat == "Funkcionalna paradigma")then
    preboj("Funkcionalna",460,160,font)
  else
    ispis("Funkcionalna",460,160, font)
  end
  if(kat == "Imperativna paradigma")then
    preboj("Imperativna",460,260,font)
  else
    ispis("Imperativna",460,260, font)
  end
  if(kat == "Osnovna pitanja")then
    preboj("Osnovna",60,60,font)
  else
    ispis("Osnovna",60,60, font)
  end
end

function snesko()
	love.graphics.setColor(255, 255, 255)
  love.graphics.circle("fill",650,540,60)
  love.graphics.circle("fill",650,450,40)
    love.graphics.setColor(0,0,0)
  love.graphics.circle("fill",640,440,3)
  love.graphics.circle("fill",660,440,3)
  love.graphics.circle("fill",650,500,5)
  love.graphics.circle("fill",650,520,5)
  love.graphics.circle("fill",650,540,5)
    love.graphics.setColor(235,13,13)
  love.graphics.polygon("fill",647,450,653,450,650,460)
	love.graphics.setColor(0,0,0)
  love.graphics.arc( "fill", 650, 463, 7, 0, math.pi )
  	love.graphics.setColor(255, 255, 255)
  love.graphics.arc( "fill", 650, 463, 3, 0, math.pi )
end

function initSnowAnimation()
	local animation = {}
	animation.snowflakes = {}
	animation.state = "stop"
	animation.windSpeed = 0
	animation.imgObject = love.graphics.newImage("snowflake.png")

	animation.play = function()
		animation.state = "play"
	end
	animation.stop = function()
		animation.state = "stop"
	end
	animation.destroy = function()
		animation.snowflakes = {}
	end
	animation.draw = function()
		for i = #animation.snowflakes, 1, -1 do
			love.graphics.setColor(36, 36, 90)
			love.graphics.draw(animation.imgObject, animation.snowflakes[i].x, animation.snowflakes[i].y, 0, animation.snowflakes[i].size, animation.snowflakes[i].size)
		end
	end
	animation.changeCoords = function()
		if animation.state == "play" then
			-- kreiranje novih pahuljica
			if(love.math.random() < 0.08) then
				animation.snowflakes[#animation.snowflakes + 1] = animation.createSnowflake(love.math.random(-0.5 * love.graphics.getWidth(), 1.5*love.graphics.getWidth()), 0.5 + love.math.random() / 2)
			end
			for i = #animation.snowflakes, 1, -1 do
				animation.snowflakes[i].y = animation.snowflakes[i].y + 1
				animation.snowflakes[i].x = animation.snowflakes[i].x + animation.windSpeed
				if animation.snowflakes[i].y > love.graphics.getHeight() then
					table.remove(animation.snowflakes, i)
				end
			end
		end
	end
	animation.createSnowflake = function(x, size)
		local temp = {}
		temp.x = x;
		temp.y = -animation.imgObject:getHeight();
		temp.size = size;
		return temp;
	end
	return function(action)
		if action == "play" then
			animation.play()
		elseif action == "stop" then
			animation.stop()
		elseif action == "destroy" then
			animation.destroy()
		elseif action == "draw" then
			animation.draw()
		elseif action == "changeCoords" then
			animation.changeCoords()
		end
	end
end
