module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	reg [2:0] state;
	reg z;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // state A
			z <= 1'b0;
		end else begin
			case (state)
				3'b000: begin // state A
					if (w)
						state <= 3'b001; // state B
					else
						state <= 3'b000; // state A
					z <= 1'b0;
				end
				3'b001: begin // state B
					if (w)
						state <= 3'b010; // state C
					else
						state <= 3'b011; // state D
					z <= 1'b0;
				end
				3'b010: begin // state C
					if (w)
						state <= 3'b100; // state E
					else
						state <= 3'b011; // state D
					z <= 1'b0;
				end
				3'b011: begin // state D
					if (w)
						state <= 3'b101; // state F
					else
						state <= 3'b000; // state A
					z <= 1'b0;
				end
				3'b100: begin // state E
					if (w)
						state <= 3'b100; // state E
					else
						state <= 3'b011; // state D
					z <= 1'b1;
				end
				3'b101: begin // state F
					if (w)
						state <= 3'b010; // state C
					else
						state <= 3'b011; // state D
					z <= 1'b1;
				end
				default: begin
					state <= 3'b000; // state A
					z <= 1'b0;
				end
			endcase
		end
	end

endmodule
