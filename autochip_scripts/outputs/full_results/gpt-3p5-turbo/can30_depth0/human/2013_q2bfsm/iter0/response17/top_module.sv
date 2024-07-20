module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f_reg, g_reg;
reg [2:0] state_reg;

always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		f_reg <= 0;
		g_reg <= 0;
		state_reg <= 3'b000; // state A
	end
	else begin
		case (state_reg)
			3'b000: begin // state A
				f_reg <= 0;
				if (resetn && (x == 1'b1))
					state_reg <= 3'b001; // state B
				else
					state_reg <= 3'b000; // state A
			end
			3'b001: begin // state B
				f_reg <= 1;
				state_reg <= 3'b010; // state C
			end
			3'b010: begin // state C
				if (x == 1'b0)
					state_reg <= 3'b011; // state D
				else
					state_reg <= 3'b010; // state C
			end
			3'b011: begin // state D
				if (x == 1'b1)
					state_reg <= 3'b101; // state F
				else
					state_reg <= 3'b011; // state D
			end
			3'b101: begin // state F
				if (y == 1'b1)
					state_reg <= 3'b101; // state F
				else if (y == 1'b0)
					state_reg <= 3'b110; // state G
			end
			3'b110: begin // state G
				g_reg <= 0;
				state_reg <= 3'b111; // state H
			end
			3'b111: begin // state H
				if (resetn)
					state_reg <= 3'b000; // state A
			end
		endcase
	end
end

assign f = f_reg;
assign g = g_reg;

endmodule
