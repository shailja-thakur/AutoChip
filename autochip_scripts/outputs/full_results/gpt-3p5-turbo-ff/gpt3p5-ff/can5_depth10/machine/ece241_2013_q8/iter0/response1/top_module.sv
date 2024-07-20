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
	
	reg [1:0] state; // current state
	reg [1:0] state_next; // next state
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S; // Initial state
		end else begin
			state <= state_next; // Update state
		end
	end
	
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b1) begin
					state_next = S1;
				end else begin
					state_next = S;
				end
				z <= 1'b0;
			end
			S1: begin
				if (x == 1'b1) begin
					state_next = S1;
				end else begin
					state_next = S10;
				end
				z <= 1'b0;
			end
			S10: begin
				if (x == 1'b1) begin
					state_next = S1;
				end else begin
					state_next = S;
				end
				z <= x;
			end
		endcase
	end
endmodule
