module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;
reg [2:0] w_count;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
		w_count <= 3'b000;
		z <= 1'b0;
	end else begin
		case (state)
			2'b00:
				if (s == 1'b1)
					state <= 2'b01;
				else
					state <= 2'b00;
			2'b01:
				if (w == 1'b1)
					w_count <= w_count + 1'b1;
				if (w_count == 3'b110)
					state <= 2'b10;
				else if (w_count == 3'b111)
					state <= 2'b01;
				else
					state <= 2'b01;
			2'b10:
				z <= 1'b1;
				state <= 2'b00;
		endcase
	end
end

endmodule
