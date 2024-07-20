module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state_reg, next_state;
	
	// Define state codes
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	localparam E = 3'b100;
	localparam F = 3'b101;
	
	// State table
	always @(state_reg or w)
	begin
		case (state_reg)
			A : 
				begin
					if (w)
						next_state = B;
					else
						next_state = A;
				end
			B : 
				begin
					if (w)
						next_state = C;
					else
						next_state = D;
				end
			C : 
				begin
					if (w)
						next_state = E;
					else
						next_state = D;
				end
			D : 
				begin
					if (w)
						next_state = F;
					else
						next_state = A;
				end
			E : 
				begin
					if (w)
						next_state = E;
					else
						next_state = D;
				end
			F : 
				begin
					if (w)
						next_state = C;
					else
						next_state = D;
				end
			default : next_state = A;
		endcase
	end
	
	// State flip-flops
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= next_state;
	end
	
	// FSM output
	assign z = (state_reg == E || state_reg == F);
	
endmodule
