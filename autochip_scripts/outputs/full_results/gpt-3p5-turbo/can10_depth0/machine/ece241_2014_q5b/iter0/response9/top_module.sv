module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state; // state register

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A; // set state to A
	end else begin
		// state transition logic
		case (state)
			A: begin
				if (x) begin
					state <= B; // transition to state B if x is 1
				end else begin
					state <= A; // stay in state A if x is 0
				end
			end
			
			B: begin
				state <= B; // stay in state B
			end
		endcase
	end
end

assign z = (state == A && x) || (state == B && !x); // assign output z based on state and x

endmodule
