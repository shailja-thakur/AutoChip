module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	enum logic [1:0] states;
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Define state variables
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Define state transitions and output assignments
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	always @(*) begin
		case (state)
			S: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = 0;
			end
			
			S1: begin
				if (x == 0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
				z = 0;
			end
			
			S10: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = x;
			end
		endcase
	end

endmodule
