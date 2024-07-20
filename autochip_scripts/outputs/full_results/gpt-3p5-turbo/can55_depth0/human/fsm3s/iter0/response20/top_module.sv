module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// parameter for number of states
	parameter NUM_STATES = 4;

	// states enumeration
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	reg state_reg;
	reg next_state_reg;
	reg out_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state_reg;
		end
	end
	
	// next state and output logic
	always @(state_reg, in) begin
		case(state_reg)
			A: begin
				if (in) begin
					next_state_reg = B;
				end else begin
					next_state_reg = A;
				end
				out_reg = 0;
			end
			B: begin
				if (in) begin
					next_state_reg = B;
				end else begin
					next_state_reg = C;
				end
				out_reg = 0;
			end
			C: begin
				if (in) begin
					next_state_reg = D;
				end else begin
					next_state_reg = A;
				end
				out_reg = 0;
			end
			D: begin
				if (in) begin
					next_state_reg = B;
				end else begin
					next_state_reg = C;
				end
				out_reg = 1;
			end
			
		endcase
	end

	// assign output signal
	assign out = out_reg;

endmodule
