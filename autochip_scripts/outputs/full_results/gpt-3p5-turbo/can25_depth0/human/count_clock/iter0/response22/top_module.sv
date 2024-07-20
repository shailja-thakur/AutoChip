module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);
	
	reg [3:0] h1;   // Higher digit of hours
	reg [3:0] h0;   // Lower digit of hours
	reg [3:0] m1;   // Higher digit of minutes
	reg [3:0] m0;   // Lower digit of minutes
	reg [3:0] s1;   // Higher digit of seconds
	reg [3:0] s0;   // Lower digit of seconds
	
	// Counter for hours (12-hour format)
	always @(posedge clk or posedge reset) begin
		if(reset)
			{h1, h0} <= 4'b0000;   // Initialize to 12:00 AM
		else if(ena)
			if({h1, h0} == 4'b1011)  // If current time is 11:xx
				{h1, h0} <= {1'b0, 3'b0000};  // Increment to 12:xx (AM to PM)
			else if({h1, h0} == 4'b1101)  // If current time is 12:xx
				{h1, h0} <= {3'b000, 1'b0};  // Increment to 01:xx (PM to AM)
			else
				{h1, h0} <= {h1[2:0], h0[2:0] + 1'b1};  // Increment hours normally
	end
	
	// Counter for minutes
	always @(posedge clk or posedge reset) begin
		if(reset)
			{m1, m0} <= 4'b0000;   // Initialize to 12:00 AM
		else if(ena)
			if({m1, m0} == 4'b0101)  // If current time is xx:59
				{m1, m0} <= {1'b0, 3'b0000};  // Increment to xx:00
			else
				{m1, m0} <= {m1[2:0], m0[2:0] + 1'b1};  // Increment minutes normally
	end
	
	// Counter for seconds
	always @(posedge clk or posedge reset) begin
		if(reset)
			{s1, s0} <= 4'b0000;   // Initialize to 12:00 AM
		else if(ena)
			if({s1, s0} == 4'b0101)  // If current time is xx:xx:59
				{s1, s0} <= {1'b0, 3'b0000};  // Increment to xx:xx:00
			else
				{s1, s0} <= {s1[2:0], s0[2:0] + 1'b1};  // Increment seconds normally
	end
	
	// Update final outputs
	always @* begin
		hh = {pm, h1, h0};   // Concatenate AM/PM indicator and hours
		mm = {m1, m0};   // Concatenate minutes
		ss = {s1, s0};   // Concatenate seconds
		
		if({h1, h0} == 4'b1011)   // If current time is 11:xx
			pm = 1'b1;   // Set PM indicator
		else if({h1, h0} == 4'b1101)   // If current time is 12:xx
			pm = 1'b0;   // Set AM indicator
	end
	
endmodule
