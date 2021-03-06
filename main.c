/*
    main - main program, initialize and start
    Copyright (C) 2011 Pavel Semerad

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/



#include "cr3p.h"

//#include "lcd.h"
//#include "timer.h"
//#include "buzzer.h"
//#define LCD_TEST


// init functions from other source files (libraries)
extern void ppm_init(void);
extern void lcd_init(void);
extern void input_init(void);
extern void input_read_first_values(void);
extern void buzzer_init(void);
extern void timer_init(void);
extern void task_init(void);
extern void calc_init(void);
extern void menu_init(void);



// switch to clock from external crystal
static void clock_init(void) {
    CLK_PCKENR1 = 0;	// disable clocks to peripherals
    CLK_PCKENR2 = 0;
    BSET(CLK_ECKCR, 0);	// enable HSE
    while (!(CLK_ECKCR & 0x02)) {}  // wait for HSE ready
    CLK_CKDIVR = 0;	// no clock divide
    BSET(CLK_SWCR, 1);	// start switching clock
    CLK_SWR = 0xB4;	// select HSE
    while (!(CLK_SWCR & 0x08)) {}  // wait for clock switch
    if (CLK_CMSR != 0xB4) {
	// switch to HSE NOT done, stop
	while (1) {}
    }
    BSET(CLK_CSSR, 0);	// clock security system on
}

// set power on
static void pwrbut_init(void) {
    u16 x = 50000;

    IO_OP(D, 6);       // PWREN    
    //BRES(PD_ODR, 6); // PWR off
    BSET(PD_ODR, 6);   // PWR on
    IO_IP(D, 5);       // PWRBUT
    while(x--);	       // stabilize
    IO_OO(D, 7);       // LED
    BRES(PD_ODR, 7);   // LED on
    //BSET(PD_ODR, 7); // LED off    
}

// copyright to firmware
static u8 *copret(void) {
    static const u8 copyright[] = "(C) 2011-2012 Pavel Semerad";
    return copyright;
}


// main program
void main(void) {

    // initialize modules

    clock_init();
    pwrbut_init();      // power on
    task_init();
    input_init();	// here to have time to stabilize ADC
    buzzer_init();
    ppm_init();
    lcd_init();
    calc_init();
    input_read_first_values();
    timer_init();

    // enable interrupts
    rim();

    // init menus and do processing
    menu_init();




#ifdef LCD_TEST
    {
	u16 wait_time;
	static volatile u8 t, p1, p2, p3, p4, data, com, v, m;

	backlight_on_sec(BACKLIGHT_MAX);
	lcd_clear();
        p1 = ' ';//0xdf;
	p2 = 1;
	p3 = 0;
	p4 = 0;
	data = 0;
	com = 0;
	v = 0; 
	m = 1; 

	while (1) {
	    t = 5;
	    
	    //help = (u8)(com << 6);
	    //p1 = (u8)((help & 0b11000000) | (data & 0b00011111));
	    //p1 = data;
	    //p1 = 13;
	    
	    if (t == 0)       lcd_clear();
	    else if (t == 1)  lcd_segment(data++, 1);
	    else if (t == 2)  lcd_segment_blink(p1, p2);
	    else if (t == 3)  lcd_set(p1, (u8 *)(((u16)p2 << 8) | p3));
	    else if (t == 4)  lcd_set_blink(p1, p2);
	    else if (t == 5)  { 
	      lcd_char(0, p1++);
	      lcd_char(1, p1++);
	      lcd_char(2, p1++);
	    }
	    else if (t == 6)  lcd_char_num3(((u16)p1 << 8) | p2);
	    //else if (t == 7)  lcd_char_num2((s8)p1);
	    else if (t == 8)  lcd_7seg(v++);
	    else if (t == 9)  { lcd_menu(m); m = (u8)(m << 1); }
	    else if (t == 10) lcd_set_full_on();
	    else if (t == 11) lcd_chars((u8 *)&p1);
	    else if (t == 12) lcd_char_num2_lbl((s8)p1, (u8 *)&p2);
	         
	
	    beep(1);
	    lcd_update();
	 /*   
	    while(BCHK(PD_IDR, 5));
            x = 50000;
            while(x--);
            while(!BCHK(PD_IDR, 5));
	    x = 50000;
            while(x--);
	    
	    data++;
	    if(data == 32)
	    {	 
	            com++;
		    data = 0; 
		    if(com == 4){
	               BSET(PD_ODR, 7); // LED off
                       BRES(PD_ODR, 6); // PWR off
                       IO_IF(D, 6);     
                       IO_IF(D, 5);  

                       x = 1;
                       while(x);
		    }
	    }	    
	    */
	    // wait 5s
	    wait_time = time_sec + 1;
	    while (time_sec < wait_time)  pause();
	}
    }
#endif

#ifdef LCD_BASIC_TEST
    {
	u16 last_time = time_sec;
	IO_OP(D, 0);

	backlight_on_sec(60);
	lcd_clear();

	while (1) {
	    while (last_time == time_sec)  pause();
	    BSET(PD_ODR, 0);
	    last_time = time_sec;
	    beep(20);
	    lcd_segment(LS_SYM_MODELNO, LS_OFF);
	    lcd_update();
	    while (last_time == time_sec)  pause();
	    BRES(PD_ODR, 0);
	    last_time = time_sec;
	    lcd_segment(LS_SYM_MODELNO, LS_ON);
	    lcd_update();
	}
    }
#endif

#ifdef PPM_TEST
    // test 8 channels, switch values each 5 seconds
    ppm_set_channels(8);
    {
    extern volatile _Bool ppm_update_values;
    u8 i, j;
    while (1) {
	for (i = 0; i < 222; i++) {
	    for (j = 1; j <= channels; j++) {
		ppm_set_value(j, 10000);
	    }
	    ppm_calc_sync();
	    while (ppm_update_values) {}  // wait for interrupt routine
	}
	for (i = 0; i < 222; i++) {
	    for (j = 1; j <= channels; j++) {
		ppm_set_value(j, 20000);
	    }
	    ppm_calc_sync();
	    while (ppm_update_values) {}  // wait for interrupt routine
	}
    }
    }
#endif
}

