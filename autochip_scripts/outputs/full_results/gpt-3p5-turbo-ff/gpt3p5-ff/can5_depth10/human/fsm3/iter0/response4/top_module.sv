module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	
	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	// Define the outputs for each state
	always @(state) begin
		case(state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
		endcase
	end
	
	// Define the state transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Define the next state logic based on the input
	always @(state, in) begin
		case(state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase
	end
	
endmodule
