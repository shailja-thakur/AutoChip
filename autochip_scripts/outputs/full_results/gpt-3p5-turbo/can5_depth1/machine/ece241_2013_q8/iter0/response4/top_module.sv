module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	reg [1:0] currentState, nextState;
	
	always @(posedge clk or negedge aresetn) begin
		if(!aresetn)
			currentState <= S; // Initial state
		else
			currentState <= nextState; // Next state assignment
	end
	
	always @(currentState or x) begin
		case (currentState)
			S: begin
				case (x)
					1: nextState <= S1;
					0: nextState <= S;
				endcase
			end
			
			S1: begin
				case (x)
					1: nextState <= S1;
					0: nextState <= S10;
				endcase
			end
			
			S10: begin
				case (x)
					1: nextState <= S1;
					0: nextState <= S;
				endcase
			end
		endcase
	end
	
	always @(currentState) begin
		case (currentState)
			S, S1: z <= 0;
			S10: z <= x;
		endcase
	end
	
endmodule
