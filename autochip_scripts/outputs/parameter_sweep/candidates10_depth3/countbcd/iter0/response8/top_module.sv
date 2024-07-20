module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);
	// Internal wire to hold the count
	wire [15:0] count;
	
	// Output signals for the individual digits
	assign q[3:0] = count[3:0];
	assign q[7:4] = count[7:4];
	assign q[11:8] = count[11:8];
	assign q[15:12] = count[15:12];
	
	// Output signal for the enable for the upper three digits
	assign ena = count[13:11];
	
	// Synchronous counter with active-high reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
	end
endmodule
