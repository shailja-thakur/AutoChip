module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk or negedge resetn)
		if (!resetn)
			state <= 3'b001;
		else
			state <= next;

	always @*
		case (state)
			3'b001: next = (r[1]) ? 3'b010 : (r[2]) ? 3'b011 : (r[3]) ? 3'b100 : 3'b001;
			3'b010: next = (r[1]) ? 3'b010 : 3'b001;
			3'b011: next = (r[2]) ? 3'b011 : 3'b001;
			3'b100: next = (r[3]) ? 3'b100 : 3'b001;
			default: next = 3'b001;
		endcase

	always @*
		case (state)
			3'b010: g = 3'b001;
			3'b011: g = 3'b010;
			3'b100: g = 3'b100;
			default: g = 3'b000;
		endcase

endmodule
