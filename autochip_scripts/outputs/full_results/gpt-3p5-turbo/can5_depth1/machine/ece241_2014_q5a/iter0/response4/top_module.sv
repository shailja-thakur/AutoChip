module top_module (
	input clk,
	input areset,
	input x,
	output z
);

parameter A = 2'b00; // define state A as 00
parameter B = 2'b01; // define state B as 01
parameter C = 2'b10; // define state C as 10
reg [1:0] state;     // register to store the state of the machine

always @(posedge clk or areset) begin
	if (areset == 1'b1) begin
		state <= A; // set state to A if reset triggered
	end else begin
		case (state)
			A: begin
				if (x) begin
					state <= C; // set state to C if x is true
				end else begin
					state <= A; // stay at state A
				end
			end
			B: begin
				if (x) begin
					state <= B; // stay at state B if x is true
				end else begin
					state <= C; // set state to C
				end
			end
			C: begin
				if (x) begin
					state <= B; // set state to B if x is true
				end else begin
					state <= C; // stay at state C
				end
			end
		endcase
	end
end

assign z = (state == C) ? 1'b1 : 1'b0; // set output z to true if state is C, otherwise false

endmodule
