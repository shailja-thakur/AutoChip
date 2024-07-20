module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
	if (!resetn)
		state <= 2'b00;
	else
		state <= next;
end

always @(*) begin
	case (state)
		2'b00: begin
			if (r[2])
				next = 2'b10;
			else if (r[1])
				next = 2'b01;
			else if (r[0])
				next = 2'b11;
			else
				next = 2'b00;
		end
		2'b01: begin
			if (r[1])
				next = 2'b01;
			else
				next = 2'b00;
		end
		2'b10: begin
			if (r[2])
				next = 2'b10;
			else
				next = 2'b00;
		end
		2'b11: begin
			if (r[0])
				next = 2'b11;
			else
				next = 2'b00;
		end
	endcase
end

assign g[2] = (state == 2'b10);
assign g[1] = (state == 2'b01);
assign g[0] = (state == 2'b11);

endmodule
