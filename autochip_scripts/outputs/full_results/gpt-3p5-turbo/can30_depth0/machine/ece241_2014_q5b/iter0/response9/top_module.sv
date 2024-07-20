module top_module (
	input clk,
	input areset,
	input x,
	output z
);


reg [1:0] state;
// State machine initial state assignment
initial state = 2'b00;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00; // When asynchronous reset is asserted, state is set to A
	else
		case (state)
			2'b00: begin
				if (x)
					state <= 2'b01; // If state is A and x is 1, state transitions to B
			end
			2'b01: begin
				state <= 2'b01; // If state is B, state remains B
			end
		endcase
end

assign z = (state == 2'b00 && x) || (state == 2'b01 && !x);

endmodule
