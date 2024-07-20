module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Internal wire declarations
	wire [3:0] hours_tens;
	wire [3:0] hours_ones;
	wire [3:0] minutes_tens;
	wire [3:0] minutes_ones;
	wire [3:0] seconds_tens;
	wire [3:0] seconds_ones;
	
	// Counter declarations
	counter counter_hours_tens(.clk(clk), .reset(reset), .ena(ena), .out(hours_tens));
	counter counter_hours_ones(.clk(clk), .reset(reset), .ena(ena && hours_tens[3]), .out(hours_ones));
	counter counter_minutes_tens(.clk(clk), .reset(reset), .ena(ena && hours_ones[3]), .out(minutes_tens));
	counter counter_minutes_ones(.clk(clk), .reset(reset), .ena(ena && minutes_tens[3]), .out(minutes_ones));
	counter counter_seconds_tens(.clk(clk), .reset(reset), .ena(ena && minutes_ones[3]), .out(seconds_tens));
	counter counter_seconds_ones(.clk(clk), .reset(reset), .ena(ena && seconds_tens[3]), .out(seconds_ones));
	
	// Convert BCD digits to binary for display
	decoder dec_hours_tens(.in(hours_tens), .out(hh[7:4]));
	decoder dec_hours_ones(.in(hours_ones), .out(hh[3:0]));
	decoder dec_minutes_tens(.in(minutes_tens), .out(mm[7:4]));
	decoder dec_minutes_ones(.in(minutes_ones), .out(mm[3:0]));
	decoder dec_seconds_tens(.in(seconds_tens), .out(ss[7:4]));
	decoder dec_seconds_ones(.in(seconds_ones), .out(ss[3:0]));
	
	// PM indicator
	assign pm = hours_tens[2];
	
endmodule
