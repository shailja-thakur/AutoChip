module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// states
	enum {B, A} state;
	
	// next state logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else begin
			case(state)
				B: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				A: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
				default: state <= B;
			endcase
		end
	end
	
	// output logic
	always @(state) begin
		case(state)
			B: out <= 1;
			A: out <= 0;
			default: out <= 1;
		endcase
	end

endmodule
