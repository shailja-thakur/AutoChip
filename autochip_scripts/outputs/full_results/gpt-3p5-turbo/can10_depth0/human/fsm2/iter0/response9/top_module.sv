module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;
wire out;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= OFF;
		out_reg <= 0;
	end else begin
		case(state)
			OFF: begin
				if (j) begin
					state <= ON;
					out_reg <= 0;
				end else begin
					state <= OFF;
					out_reg <= 0;
				end
			end
			ON: begin
				if (k) begin
					state <= OFF;
					out_reg <= 1;
				end else begin
					state <= ON;
					out_reg <= 1;
				end
			end
		endcase
	end
end

assign out = out_reg;

endmodule
