module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [3:0] state;
	always @(posedge clk, negedge resetn) begin
		if (!resetn)
			state <= 0;
		else begin
			case (state)
				0: // A state
					if (x)
						state <= 1;
					else
						state <= 2;
				1: // B state
					state <= 0;
				2: // S0 state
					if (x)
						state <= 3;
				else
					state <= 2;
				3: // S1 state
					if (x)
						state <= 3;
				else
					state <= 4;
				4: // S10 state
					if (x)
						state <= 6;
				else
					state <= 2;
				5: // G1 state
					if (y)
						state <= 7;
				else
					state <= 8;
				6: // G2 state
					if (y)
						state <= 7;
				else
					state <= 9;
				7: // P1 state
					state <= 7;
				8: // P0 state
					state <= 8;
			endcase
		end
	end

	assign f = (state == 1) ? 1'b1 : 1'b0;
	assign g = (state == 5 || state == 6 || state == 7) ? 1'b1 : 1'b0;

endmodule
