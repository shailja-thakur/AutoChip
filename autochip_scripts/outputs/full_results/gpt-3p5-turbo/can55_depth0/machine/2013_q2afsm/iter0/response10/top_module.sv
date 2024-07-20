module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= 2'b00;
	else
		state <= next;
end

always @(*) begin
	case (state)
		2'b00: begin
			if (r[2]) next = 2'b10;
			else if (r[1]) next = 2'b01;
			else if (r[0]) next = 2'b10;
			else next = 2'b00;
		end
		2'b01: next = (r[1]) ? 2'b01 : 2'b00;
		2'b10: next = (r[2]) ? 2'b10 : 2'b00;
		2'b11: next = (r[0]) ? 2'b11 : 2'b00;
	endcase
end

always @(*) begin
	case (state)
		2'b00: g = 3'b000;
		2'b01: g = 3'b001;
		2'b10: g = 3'b010;
		2'b11: g = 3'b100;
	endcase
end

endmodule
