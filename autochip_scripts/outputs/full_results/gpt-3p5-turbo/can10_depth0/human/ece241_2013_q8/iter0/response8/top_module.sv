module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	reg [1:0] state, next_state;
	
	parameter S0 = 2'b00; // idle state
	parameter S1 = 2'b01; // sequence detecting state
	parameter S2 = 2'b10; // sequence detected state
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0; // initialize state to idle state on reset
		end else begin
			state <= next_state; // update state based on next state
		end
	end

	always @(state or x) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state <= S1; // move to sequence detecting state if input is 1
				end else begin
					next_state <= S0; // stay in idle state if input is 0
				end				
			end
			
			S1: begin
				if (x == 1'b0) begin
					next_state <= S0; // move back to idle state if input is 0
				end else if (x == 1'b1) begin
					next_state <= S2; // move to sequence detected state if input is 1
				end
			end
			
			S2: begin
				if (x == 1'b0) begin
					next_state <= S0; // move back to idle state if input is 0
				end else if (x == 1'b1) begin
					next_state <= S2; // stay in sequence detected state if input is 1
				end
			end
		endcase
	end
	
	always @(state) begin
		if (state == S2) begin
			z <= 1'b1; // assert output z if sequence "101" is detected
		end else begin
			z <= 1'b0; // deassert output z in all other states
		end
	end

endmodule
