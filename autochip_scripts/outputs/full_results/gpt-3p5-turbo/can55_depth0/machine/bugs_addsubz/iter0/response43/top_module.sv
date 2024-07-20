module top_module (
	input do_sub,
	input [7:0] a,
	input [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

always @(do_sub or a or b) begin
	// Perform addition or subtraction based on do_sub value
	case(do_sub)
		0: begin
			out = a + b;
		end
		1: begin
			out = a - b;
		end
		default: begin
			out = 8'hZZ; // Unknown behavior
		end
	endcase
	
	// Check if the result is zero and set result_is_zero accordingly
	if(out == 0) begin
		result_is_zero = 1;
	end
	else begin
		result_is_zero = 0;
	end
end

endmodule
