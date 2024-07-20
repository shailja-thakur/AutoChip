module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:0] state;
reg [3:0] next;

always @(posedge clk) begin
	if (!resetn)
		state <= 3'b000;
	else
		state <= next;
end

always @(state, r) begin
	case (state)
		0: begin
			if (r[1])
				next = 3'b010;
			else if (r[2])
				next = 3'b011;
			else if (r[3])
				next = 3'b100;
			else
				next = 3'b000;
		end
		1: begin
			if (r[1])
				next = 3'b001;
			else
				next = 3'b000;
		end
		2: begin
			if (r[2])
				next = 3'b010;
			else
				next = 3'b000;
		end
		3: begin
			if (r[3])
				next = 3'b011;
			else
				next = 3'b000;
		end
	endcase
end

assign g[1] = (state == 1);
assign g[2] = (state == 2);
assign g[3] = (state == 3);

endmodule
