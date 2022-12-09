#SingleInstance force
#NoEnv

triger := false
global g := false

CorSet := 0
PosSetX := 0
PosSetY := 0

x::ExitApp

GreenkRect(x, y, w, h, cor) {	
	static n := 0
	n++
	Gui, %n%:-Caption +AlwaysOnTop +ToolWindow
	Gui, %n%:Color, %cor%
	Gui, %n%:Show, x%x% y%y% w%w% h%h%
	return n
}
m::
	Main()
	v:: ;
		VerificarWindow()
	return
return

DestroyBR(n) {
	Gui, %n%:Destroy
	ToolTip
}

Main(){
	g := GreenkRect(100, 100, 100, 100, 0)
	Loop {
		MouseGetPos, mx, my
		PixelGetColor, novaCor, %mx%, %my%
		corN := NormalizarCor(novaCor)
		Gui, %g%:Color,%corN%
		;ToolTip, %corN%, 100, 100
	}

}

NormalizarCor(cor){
	a := SubStr(cor, 7,2)
	b := SubStr(cor, 5,2)
	c := SubStr(cor, 3,2)
	x := SubStr(cor, 1,2)
	return, x a b c
}


VerificarWindow(){

	WinGetActiveTitle, NomeDaJanela
	WinGetActiveStats, Title, Width, Height, Xw, Yw
	
	if(NomeDaJanela == "Mir4G[0]" || NomeDaJanela == "Mir4G[1]"){
		DestroyBR(g)
		CoordMode, Mouse, Relative
		CoordMode, Pixel, Relative
		MouseGetPos, MouseX, MouseY
		PixelGetColor, acor, MouseX, MouseY
		corN := NormalizarCor(acor)

		CorSet := corN
		PosSetX := MouseX
		PosSetY := MouseY
		SoundBeep, 750, 500
		;MsgBox %CorSet% %PosSetX% %PosSetY%

		Loop {
			WinGetActiveTitle, NewJanela
			if(NewJanela == "Mir4G[0]" || NewJanela == "Mir4G[1]"){
				PixelGetColor, c, PosSetX, PosSetY
				nCor := NormalizarCor(c)
				
				if (nCor != CorSet)
				{
					;MsgBox %nCor% != %CorSet%
					Run, nircmd.exe savescreenshot shot.png %Xw% %Yw% %Width% %Height%
					Sleep, 860
					Run MOD.bat
					SoundBeep, 750, 500
					ExitApp	
				}
			}
		}
	}
	return
	
}


PixelDaJanela(){
	CoordMode, Pixel, Relative
	PixelGetColor, cohR, Width - 50, 50
	return NormalizarCor(cohR)
}






