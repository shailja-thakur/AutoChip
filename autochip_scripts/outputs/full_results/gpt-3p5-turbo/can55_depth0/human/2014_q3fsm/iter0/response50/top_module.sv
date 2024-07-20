module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 2'b00;
	else begin
		case (state)
			2'b00: begin
				if (s) state <= 2'b01;
				else state <= 2'b00;
			end
			2'b01: begin
				if (w) state <= 2'b10;
				else state <= 2'b01;
			end
			2'b10: begin
				if (w) state <= 2'b11;
				else state <= 2'b00;
			end
			2'b11: begin
				if (w) state <= 2'b11;
				else state <= 2'b00;
			end
			default: state <= 2'b00;
		endcase
	end
end

always @(posedge clk) begin
	if (reset)
		z <= 1'b0;
	else begin
		case (state)
			2'b10: begin
				if ((w == 1'b1 && wnxt == 1'b1) || (w == 1'b1 && wpast == 1'b1))
					z <= 1'b1;
				else
					z <= 1'b0;
			end
			default: z <= 1'b0;
		endcase
	end
end

endmodule
