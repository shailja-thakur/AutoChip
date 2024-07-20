module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	parameter B = 1'b0;
	parameter A = 1'b1;
	
	// Define outputs
	reg out;
	
	// Define current state
	reg state;
	
	// Define next state
	reg next_state;
	
	// Define default next state as current state
	always @(*) begin
		next_state = state;
	end
	
	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			case(state)
				B: begin
					if(in == 1'b0)
						next_state <= A;
					else
						next_state <= B;
				end
				A: begin
					if(in == 1'b0)
						next_state <= B;
					else
						next_state <= A;
				end
			endcase
		end
	end
	
	// Combining next state to current state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end
	
	// Output assignment based on state
	always @(*) begin
		case(state)
			B: begin
				out = 1'b1;
			end
			A: begin
				out = 1'b0;
			end
		endcase
	end
	
endmodule
