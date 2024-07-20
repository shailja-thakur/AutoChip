module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [1:0] state;
	reg [1:0] next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= 2'b00;
		else
			state <= next_state;
	end

	always @(*) begin
		case(state)
			2'b00: begin
				if (r[1])
					next_state = 2'b01;
				else if (r[2])
					next_state = 2'b10;
				else if (r[3])
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
			2'b01: begin
				if (r[1])
					next_state = 2'b01;
				else
					next_state = 2'b00;
			end
			2'b10: begin
				if (r[2])
					next_state = 2'b10;
				else
					next_state = 2'b00;
			end
			2'b11: begin
				if (r[3])
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
		endcase
	end

	always @(state) begin
		case(state)
			2'b01: g[1] = 1'b1;
			2'b10: g[2] = 1'b1;
			2'b11: g[3] = 1'b1;
			default: begin
				g[1] = 1'b0;
				g[2] = 1'b0;
				g[3] = 1'b0;
			end
		endcase
	end

endmodule
