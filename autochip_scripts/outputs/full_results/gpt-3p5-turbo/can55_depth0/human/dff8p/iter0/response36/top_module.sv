module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

// Create 8 D flip-flops with active high synchronous reset
reg [7:0] q_temp;
always @(negedge clk or posedge reset) begin
	if (reset) begin
		q_temp <= 8'b00110100; // Reset value of 0x34
	end else begin
		q_temp <= d;
	end
end

// Assign q_temp to q
assign q = q_temp;

endmodule
