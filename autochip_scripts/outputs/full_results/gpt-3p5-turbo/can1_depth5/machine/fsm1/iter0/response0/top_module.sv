module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b01; // reset to state B
		end else begin
			case (state)
				2'b00: if (in) state <= 2'b00; else state <= 2'b01; // state A
				2'b01: if (in) state <= 2'b01; else state <= 2'b00; // state B
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output is high when state is B

endmodule
