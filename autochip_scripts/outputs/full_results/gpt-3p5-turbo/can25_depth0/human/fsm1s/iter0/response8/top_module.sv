module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State enumeration
	typedef enum [1:0] {
		B,
		A
	} state_type;
	
	// State register
	reg [1:0] state_reg;
	
	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= B;
		end else begin
			case (state_reg)
				B: begin
					if (in == 0)
						state_reg <= A;
					else
						state_reg <= B;
					end
				A: begin
					if (in == 0)
						state_reg <= B;
					else
						state_reg <= A;
					end
				default: state_reg <= B;
			endcase
		end
	end
	
	// Output logic
	always @(state_reg) begin
		case (state_reg)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase
	end
	
endmodule
