module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // state A
		out <= 1'b0;
	end else begin
		case(state)
			2'b00: begin // state A
				if (in)
					state <= 2'b01; // state B
				else
					state <= 2'b00; // state A
				out <= 1'b0;
			end
			2'b01: begin // state B
				if (in)
					state <= 2'b01; // state B
				else
					state <= 2'b10; // state C
				out <= 1'b0;
			end
			2'b10: begin // state C
				if (in)
					state <= 2'b11; // state D
				else
					state <= 2'b00; // state A
				out <= 1'b0;
			end
			2'b11: begin // state D
				if (in)
					state <= 2'b10; // state C
				else
					state <= 2'b01; // state B
				out <= 1'b1;
			end
		endcase
	end
end

assign out = 1'b0;

endmodule
