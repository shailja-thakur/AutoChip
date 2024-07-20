module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	reg [3:1] state;
	reg [3:1] next;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 3'b001;
		end else begin
			state <= next;
		end
	end

	always @(*) begin
		case (state)
			3'b001: if (r[1]) next <= 3'b010; else if (r[2]) next <= 3'b011; else if (r[3]) next <= 3'b100; else next <= 3'b001;
			3'b010: if (r[1]) next <= 3'b010; else next <= 3'b001;
			3'b011: if (r[2]) next <= 3'b011; else next <= 3'b001;
			3'b100: if (r[3]) next <= 3'b100; else next <= 3'b001;
			default: next <= 3'b001;
		endcase
	end

	always @(*) begin
		case (state)
			3'b010: g[1] = 1'b1; g[2] = 1'b0; g[3] = 1'b0;
			3'b011: g[1] = 1'b0; g[2] = 1'b1; g[3] = 1'b0;
			3'b100: g[1] = 1'b0; g[2] = 1'b0; g[3] = 1'b1;
			default: g[1] = 1'b0; g[2] = 1'b0; g[3] = 1'b0;
		endcase
	end

endmodule
