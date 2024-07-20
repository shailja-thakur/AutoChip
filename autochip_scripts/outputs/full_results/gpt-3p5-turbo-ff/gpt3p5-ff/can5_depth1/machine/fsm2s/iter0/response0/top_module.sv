module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define states
	parameter A = 0;
	parameter B = 1;

	// Define state reg
	reg [1:0] state;
	
	// Define next state reg
	reg [1:0] next_state;

	// Output assignment
	assign out = (state == B) ? 1 : 0;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			state <= A;
		end
		else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(state, j, k) begin
		case(state)
			A: begin
				if(j) begin
					next_state = B;
				end
				else begin
					next_state = A;
				end
			end
			
			B: begin
				if(k) begin
					next_state = A;
				end
				else begin
					next_state = B;
				end
			end
		endcase
	end
	
endmodule
