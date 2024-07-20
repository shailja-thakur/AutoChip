module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] shift_register;
	reg [31:0] feedback;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_register <= 32'h1;
			q <= 32'h1;
		end else begin
			feedback[0] <= shift_register[0] ^ shift_register[31] ^ shift_register[21] ^ shift_register[1];
			shift_register <= {feedback[0], shift_register[31:1]};
			q <= shift_register;
		end
	end
endmodule
