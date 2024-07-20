module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00; // define the state A
parameter B = 2'b01; // define the state B
parameter C = 2'b10; // define the state C

reg [1:0] state; // register to store the state of the machine

always @(posedge clk or areset) begin
	if (areset == 1'b1) begin
		state <= A; // set the state to A when reset is triggered
	end else begin
		case(state)
			A: begin
				if (x == 1'b1) begin
					state <= C; // set state to C if x is true
				end else begin
					state <= A; // stay at state A
				end
			end
			B: begin
				if (x == 1'b1) begin
					state <= B; // stay at state B
				end else begin
					state <= C; // set state to C if x is false
				end
			end
			C: begin
				if (x == 1'b1) begin
					state <= B; // set state to B if x is true
				end else begin
					state <= C; // stay at state C
				end
			end
		endcase
	end
end

assign z = (state == C); // set the output to true if state is C, false otherwise

endmodule
