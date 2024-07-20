module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state;
reg f;
reg g;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b00;
		f <= 0;
		g <= 0;
	end else begin
		case (state)
			2'b00: begin // state A
				if (x == 1 && y == 1) begin
					state <= 2'b01; // transition to state B
				end
				f <= 0;
				g <= 0;
			end
			2'b01: begin // state B
				if (x == 0 && y == 0) begin
					state <= 2'b10; // transition to state C
				end
				f <= 0;
				g <= 0;
			end
			2'b10: begin // state C
				if (x == 1 && y == 0) begin
					state <= 2'b11; // transition to state D
					f <= 1;
				end else if (x == 1 && y == 1) begin
					state <= 2'b01; // transition back to state B
					f <= 0;
				end
				g <= 0;
			end
			2'b11: begin // state D
				f <= 1;

				if (x == 0 && y == 0) begin
					state <= 2'b10; // transition back to state C
				end else if (y == 1) begin
					g <= 1; // set g to 1 permanently
				end else begin
					g <= 0;
				end
			end
		endcase
	end
end

endmodule
