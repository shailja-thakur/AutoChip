module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg f, g;
reg [1:0] state;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= 2'b00; // state A
		f <= 0;
		g <= 0;
	end
	else begin
		case (state)
			2'b00: begin // state A
				if (x == 1 && y == 0)
					state <= 2'b01; // state B
				else
					state <= 2'b00;
				f <= 0;
				g <= 0;
			end
			
			2'b01: begin // state B
				if (x == 1 && y == 0)
					state <= 2'b10; // state C
				else if (x == 0 && y == 1)
					state <= 2'b00; // state A
				else
					state <= 2'b01;
				f <= 1;
				g <= 0;
			end
			
			2'b10: begin // state C
				if (x == 1 && y == 0)
					state <= 2'b10;
				else if (x == 0 && y == 1)
					state <= 2'b11; // state D
				else
					state <= 2'b01; // state B
				f <= 1;
				g <= 1;
			end
			
			2'b11: begin // state D
				if (y == 1)
					state <= 2'b11;
				else
					state <= 2'b01; // state B
				f <= 1;
				g <= 0;
			end
		endcase
	end
end

endmodule
