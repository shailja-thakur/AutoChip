module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

// Define internal signals
reg [7:0] q_next;

// Flip-flops with active high synchronous reset
always @(negedge clk or posedge reset) begin
	if(reset) 
		q_next <= 8'b00110100;
	else
		q_next <= d;
end

// Register output
always @(posedge clk) begin
	q <= q_next;
end

endmodule
