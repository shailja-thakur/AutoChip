module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [3:0] state, next_state;
	
	// Define state values
	parameter S = 4'b0000;
	parameter S1 = 4'b0001;
	parameter S10 = 4'b0010;
	
	// Define next state logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Define next state transitions based on input x
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
			
			S1: begin
				if (x == 1'b0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
			end
			
			S10: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
			
			default: next_state = S;
			
		endcase
	end
	
	// Define output z based on state
	always @(state) begin
		case (state)
			S, S1: z = 1'b0;
			S10: z = x;
		endcase
	end

endmodule
