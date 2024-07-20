module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;
	
	// define the state register and next state variables
	state_t state;
	reg state_reg;
	
	// define the output register
	reg out_reg;
	
	// define the combinational logic
	always_comb begin
		case(state)
			A: begin
				if (in == 1'b1)
					state_reg = B;
				else
					state_reg = A;
			end
			B: begin
				if (in == 1'b1)
					state_reg = B;
				else
					state_reg = C;
			end
			C: begin
				if (in == 1'b1)
					state_reg = D;
				else
					state_reg = A;
			end
			D: begin
				if (in == 1'b1)
					state_reg = B;
				else
					state_reg = C;
			end
			default: begin
				state_reg = A;
			end
		endcase
		
		if (state_reg == D)
			out_reg = 1'b1;
		else
			out_reg = 1'b0;
	end
	
	// sequential logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			state <= A;
		end else begin
			state <= state_reg;
		end
	end
	
	// assign the output
	assign out = out_reg;

endmodule
