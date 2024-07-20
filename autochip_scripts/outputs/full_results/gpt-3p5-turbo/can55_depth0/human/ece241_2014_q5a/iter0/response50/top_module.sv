module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or negedge areset)
begin
	if (areset === 0)
		state <= 3'b000;
	else if (state === 3'b000)
		state <= 3'b001;
	else if (x === 1'b0)
		state <= (state === 3'b001) ? 3'b010 : 3'b001;
	else
		state <= (state === 3'b001) ? 3'b011 : 3'b100;
end

always @(state or x)
begin
	case (state)
		3'b000: z <= 1'b0;
		3'b001: z <= 1'b1;
		3'b010: z <= 1'b0;
		3'b011: z <= 1'b1;
		3'b100: z <= 1'b0;
		default: z <= 1'b0;
	endcase
end

endmodule
