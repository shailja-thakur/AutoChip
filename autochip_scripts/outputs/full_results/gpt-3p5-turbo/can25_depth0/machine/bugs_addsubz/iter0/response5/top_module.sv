module top_module (
	input wire do_sub,          // input for operation selection
	input wire [7:0] a,         // input operand a
	input wire [7:0] b,         // input operand b
	output reg [7:0] out,       // output result
	output reg result_is_zero   // output flag indicating if result is zero
);

	always @(*) begin
		case(do_sub)
			0: out = a + b;                 // perform addition
			1: out = a - b;                 // perform subtraction
		endcase
		
		if(out == 0)                       // check if result is zero
			result_is_zero = 1;
		else
			result_is_zero = 0;
	end
	
endmodule
