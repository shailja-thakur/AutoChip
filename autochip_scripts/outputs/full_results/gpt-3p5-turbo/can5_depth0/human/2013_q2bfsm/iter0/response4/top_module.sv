module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [2:0] state;
reg f_internal;
reg g_internal;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= 3'b000;
		f_internal <= 0;
		g_internal <= 0;
	end else begin
		case(state)
			3'b000: begin
				f_internal <= 1;
				state <= 3'b100;
			end
			3'b100: begin
				if (x == 1'b1) begin
					state <= 3'b010;
				end
			end
			3'b010: begin
				if (x == 1'b0) begin
					state <= 3'b001;
				end
			end
			3'b001: begin
				if (x == 1'b1) begin
					state <= 3'b101;
				end else begin
					state <= 3'b000;
				end
			end
			3'b101: begin
				if (y == 1'b1) begin
					state <= 3'b111;
					g_internal <= 1;
				end else begin
					g_internal <= 0;
				end
			end
			3'b111: begin
				if (y == 1'b1) begin
					state <= 3'b111;
					g_internal <= 1;
				end else begin
					g_internal <= 0;
				end
			end
		endcase
	end
end

assign f = f_internal;
assign g = g_internal;

endmodule
