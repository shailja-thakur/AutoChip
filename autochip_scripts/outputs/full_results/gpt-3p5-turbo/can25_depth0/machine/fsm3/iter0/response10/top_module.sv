module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;
		else
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // B
				2'b10: state <= (in) ? 2'b11 : 2'b00; // C
				2'b11: state <= (in) ? 2'b01 : 2'b10; // D
			endcase
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
