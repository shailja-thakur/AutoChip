module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00; // Define the states
parameter B = 2'b01;
parameter C = 2'b10;

reg [1:0] state; // Register to store the state of the machine

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A; // Set state to A on reset
	end else begin
		case(state)
			A: begin
				if (x) begin
					state <= C; // Set state to C if x is true
				end else begin
					state <= A; // Stay at state A
				end
			end
			B: begin
				if (x) begin
					state <= B; // Stay at state B
				end else begin
					state <= C; // Set state to C if x is false
				end
			end
			C: begin
				if (x) begin
					state <= B; // Set state to B if x is true
				end else begin
					state <= C; // Stay at state C
				end
			end
		endcase
	end
end

assign z = (state == C) ? 1'b1 : 1'b0; // Output is true if state is C, false otherwise

endmodule
