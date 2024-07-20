module top_module (
	input wire do_sub,
	input wire [7:0] a,
	input wire [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

	always @(do_sub or a or b) begin
		case(do_sub)
			0: begin // Addition operation
				out = a + b;
				if(out == 0)
					result_is_zero = 1;
				else
					result_is_zero = 0;
			end
			1: begin // Subtraction operation
				out = a - b;
				if(out == 0)
					result_is_zero = 1;
				else
					result_is_zero = 0;
			end
			default: begin
				out = 0; // Default assignment for out
				result_is_zero = 0; // Default assignment for result_is_zero
			end
		endcase
	end

endmodule
