module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Create temporary variables for each digit
	reg [3:0] q0, q1, q2, q3;

	// Create a wire to enable the tens and hundreds digits
	wire tens_enable, hundreds_enable;

	// Instantiate the BCD counter for each digit
	BCD_counter counter0(.clk(clk), .reset(reset), .enable(ena[0]), .q(q0));
	BCD_counter counter1(.clk(clk), .reset(reset), .enable(ena[1]), .q(q1));
	BCD_counter counter2(.clk(clk), .reset(reset), .enable(ena[2]), .q(q2));
	BCD_counter counter3(.clk(clk), .reset(reset), .enable(1'b0), .q(q3));

	// Combine the individual digit outputs into a single output
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			q[3:0] = q0;
			q[7:4] = q1;
			q[11:8] = q2;
			q[15:12] = q3;
		end
	end

	// Generate the enables for the tens and hundreds digits
	always @(*) begin
		ena[1] = (q0 == 9);
		ena[2] = (q1 == 9 && tens_enable);
		ena[3] = (q2 == 9 && hundreds_enable);
	end

	// Set the enable signals for the tens and hundreds digits
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			tens_enable <= 0;
			hundreds_enable <= 0;
		end else begin
			tens_enable <= (q0 == 9);
			hundreds_enable <= (q1 == 9 && tens_enable);
		end
	end
endmodule
