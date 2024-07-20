module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);
	always @(do_sub, a, b) begin
		case(do_sub)
			0: begin
				out <= a + b;
			end
			1: begin
				out <= a - b;
			end
			default: begin
				out <= 8'b0;
			end
		endcase

		if (out == 8'b0) begin
			result_is_zero <= 1;
		end else begin
			result_is_zero <= 0;
		end
		
	end
endmodule
