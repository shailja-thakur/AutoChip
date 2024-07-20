module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;   // reset to state A
		end else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00;   // A -> B if in is 1, otherwise stay in A
				2'b01: state <= (in) ? 2'b01 : 2'b10;   // B -> B if in is 1, otherwise C
				2'b10: state <= (in) ? 2'b11 : 2'b00;   // C -> D if in is 1, otherwise A
				2'b11: state <= (in) ? 2'b01 : 2'b10;   // D -> B if in is 1, otherwise C
			endcase
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
