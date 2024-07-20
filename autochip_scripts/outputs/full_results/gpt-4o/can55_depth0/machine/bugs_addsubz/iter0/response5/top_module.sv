module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);
	
	always @(*) begin
		case (do_sub)
			1'b0: out = a + b;   // If do_sub is 0, perform addition
			1'b1: out = a - b;   // If do_sub is 1, perform subtraction
			default: out = 8'b0; // Default case
		endcase
		
		result_is_zero = (out == 8'b0) ? 1'b1 : 1'b0; // Set result_is_zero
	end
	
endmodule
