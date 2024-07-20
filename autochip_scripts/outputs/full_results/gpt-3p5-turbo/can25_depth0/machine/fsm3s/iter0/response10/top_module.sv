module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: if (in) state <= 2'b10; else state <= 2'b00;
				2'b01: if (in) state <= 2'b10; else state <= 2'b01;
				2'b10: if (in) state <= 2'b11; else state <= 2'b01;
				2'b11: if (in) state <= 2'b10; else state <= 2'b11;
			endcase
		end
	end

	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
