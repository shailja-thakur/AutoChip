module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
	if (~resetn) state <= 2'b00;
	else state <= next;
end

always @* begin
	case(state)
	0: if(r[2]) next = 2'b10;
	   else if(r[1]) next = 2'b01;
	   else next = 2'b00;
	1: if(r[2]) next = 2'b10;
	   else next = 2'b00;
	2: if(r[0]) next = 2'b11;
	   else next = 2'b00;
	3: if(r[0]) next = 2'b11;
	   else next = 2'b00;
	endcase
end

assign g[0] = (state == 0) ? 1'b1 : 1'b0;
assign g[1] = (state == 1) ? 1'b1 : 1'b0;
assign g[2] = (state == 2) ? 1'b1 : 1'b0;

endmodule
