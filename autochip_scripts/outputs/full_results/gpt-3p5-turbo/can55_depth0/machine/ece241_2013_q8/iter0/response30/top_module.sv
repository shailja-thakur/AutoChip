module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define state variables
	reg [3:0] state, next_state;
	
	// Define state values as parameters
	parameter S = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S10 = 4'b0010;
	
	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end 
		else begin
			state <= next_state;
		end
	end

	// Update next state based on current state and input x
	always @* begin
		case (state)
			S: begin
				if (x == 0) begin
					next_state = S;
				end 
				else begin
					next_state = S1;
				end
			end
			
			S1: begin
				if (x == 0) begin
					next_state = S10;
				end 
				else begin
					next_state = S1;
				end
			end
			
			S10: begin
				if (x == 0) begin
					next_state = S;
				end 
				else begin
					next_state = S1;
				end
			end
		endcase
	end
	
	// Output logic for z
	always @* begin
		case (state)
			S, S1: begin
				z = 0;
			end
			
			S10: begin
				z = x;
			end
		endcase
	end
	
endmodule
