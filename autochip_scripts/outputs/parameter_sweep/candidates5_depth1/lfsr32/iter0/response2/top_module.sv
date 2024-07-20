module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Internal signal declaration
	reg [31:0] shift_register;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_register <= 32'h1;
		end else begin
			shift_register <= {q[30]^q[20]^q[0]^q[31], shift_register[31:1]};
		end
	end
	
	assign q = shift_register;
endmodule
