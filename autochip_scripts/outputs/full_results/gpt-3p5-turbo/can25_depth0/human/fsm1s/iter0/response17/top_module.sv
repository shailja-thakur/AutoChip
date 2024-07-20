module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b10;
		out <= 1;
	end else begin
		case (state)
			2'b00: begin
				if (in)
					state <= 2'b01;
				else
					state <= 2'b10;
			end
			2'b01: begin
				if (in)
					state <= 2'b01;
				else
					state <= 2'b00;
			end
			default: state <= 2'b10;
		endcase

		case (state)
			2'b00: out <= 0;
			default: out <= 1;
		endcase
	end
end

endmodule
