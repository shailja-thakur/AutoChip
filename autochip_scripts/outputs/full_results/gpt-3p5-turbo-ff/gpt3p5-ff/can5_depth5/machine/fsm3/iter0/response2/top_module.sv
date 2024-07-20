module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
	
always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 2'b00;    // Reset to state A
	else
	begin
		case (state)
			2'b00: state <= (in) ? 2'b01 : 2'b00;    // Transition from A to B or stay at A
			2'b01: state <= (in) ? 2'b01 : 2'b10;    // Transition from B to B or to C
			2'b10: state <= (in) ? 2'b11 : 2'b00;    // Transition from C to D or to A
			2'b11: state <= (in) ? 2'b01 : 2'b10;    // Transition from D to B or to C
		endcase
	end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;    // Output is 1 when state is D, otherwise 0

endmodule
