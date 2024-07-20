module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk) begin
		if (!resetn)
			state <= 3'b001;
		else
			state <= next;
	end

	always @(state or r) begin
		case (state)
			3'b001: begin
				if (r[3])
					next = 3'b100;
				else if (r[2])
					next = 3'b011;
				else if (r[1])
					next = 3'b010;
				else
					next = 3'b001;
			end
			3'b010: begin
				if (r[1])
					next = 3'b010;
				else
					next = 3'b001;
			end
			3'b011: begin
				if (r[2])
					next = 3'b011;
				else
					next = 3'b001;
			end
			3'b100: begin
				if (r[3])
					next = 3'b100;
				else
					next = 3'b001;
			end
		endcase
	end

	assign g[3] = (state == 3'b100);
	assign g[2] = (state == 3'b011);
	assign g[1] = (state == 3'b010);

endmodule
