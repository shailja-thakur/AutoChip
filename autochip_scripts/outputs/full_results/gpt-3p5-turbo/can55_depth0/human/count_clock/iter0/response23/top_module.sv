module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss);

	// Define internal signals
	reg [7:0] hh_temp;
	reg [7:0] mm_temp;
	reg [7:0] ss_temp;
	reg [7:0] ones_digit;
	reg [7:0] tens_digit;

	// Counter for seconds
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			ss_temp <= 8'd0;
		end
		else if (ena == 1'b1) begin
			if (ss_temp == 8'd59) begin
				ss_temp <= 8'd0;
			end
			else begin
				ss_temp <= ss_temp + 8'd1;
			end
		end
	end

	// Counter for minutes
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			mm_temp <= 8'd0;
		end
		else if (ena == 1'b1 && ss_temp == 8'd59) begin
			if (mm_temp == 8'd59) begin
				mm_temp <= 8'd0;
			end
			else begin
				mm_temp <= mm_temp + 8'd1;
			end
		end
	end

	// Counter for hours
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			hh_temp <= 8'd0;
		end
		else if (ena == 1'b1 && mm_temp == 8'd59 && ss_temp == 8'd59) begin
			if (hh_temp == 8'd11) begin
				hh_temp <= 8'd0;
			end
			else begin
				hh_temp <= hh_temp + 8'd1;
			end
		end
	end
	
	// Convert BCD to decimal for each digit
	always @* begin
		ones_digit = (ss_temp % 10) + 48; // ASCII offset
		tens_digit = (ss_temp / 10) + 48; // ASCII offset
	end

	// Assign outputs
	assign ss = {tens_digit, ones_digit};
	assign mm = mm_temp;
	assign hh = hh_temp;
	assign pm = (hh_temp >= 8'd12) ? 1'b1 : 1'b0;

endmodule
