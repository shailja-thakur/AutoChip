module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	localparam S = 2'b00;
	localparam S1 = 2'b01;
	localparam S10 = 2'b10;

	// Define the state and next state variables
	reg [1:0] state;
	reg [1:0] next_state;

	// Synchronous always block
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S; // Initial state
		end else begin
			state <= next_state; // Update state
		end
	end

	// Combinational always block
	always @(*) begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = 1'b0;
			end
			S1: begin
				if (x == 1'b0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
				z = 1'b0;
			end
			S10: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
				z = x;
			end
		endcase
	end
endmodule
