module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	parameter OFF = 2'b00;
	parameter ON = 2'b01;

	always @(posedge clk or negedge areset) begin
		if (areset) begin
			state <= OFF;
		end else begin
			case (state)
				ON: begin
					if (k) begin
						state <= OFF;
					end else begin
						state <= ON;
					end
				end
				OFF: begin
					if (j) begin
						state <= ON;
					end else begin
						state <= OFF;
					end
				end
			endcase
		end
	end

	assign out = (state == ON) ? 1'b1 : 1'b0;

endmodule
