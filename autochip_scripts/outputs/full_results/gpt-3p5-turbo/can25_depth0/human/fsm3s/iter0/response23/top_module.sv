module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define current state and next state variables
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	// Define output variable
	reg out;
	
	// Define state transition outputs
	always @(current_state, in)
	begin
		case (current_state)
			A: if (in) begin next_state = B; end else begin next_state = A; end
			B: if (in) begin next_state = B; end else begin next_state = C; end
			C: if (in) begin next_state = D; end else begin next_state = A; end
			D: if (in) begin next_state = B; end else begin next_state = C; end
		endcase
	end
	
	// Define Moore output
	always @(current_state)
	begin
		case (current_state)
			D: out = 1;
			default: out = 0;
		endcase
	end
	
	// Define synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end
	end
	
endmodule
