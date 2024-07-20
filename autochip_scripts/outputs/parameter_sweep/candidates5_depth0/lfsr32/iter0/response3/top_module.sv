module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal Register
	reg [31:0] shift_register;

	// Assign initial value for shift register
	always @(posedge clk or posedge reset) begin
		if (reset)
			shift_register <= 32'h1;
		else begin
			shift_register[0] <= shift_register[31] ^ shift_register[22] ^ shift_register[2] ^ shift_register[1];
			shift_register[1:31] <= shift_register[0:30];
		end
	end

	// Output assignment
	assign q = shift_register;

endmodule
