module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
always @(posedge clk, posedge reset) begin
	if (reset)
		state <= 0;
	else begin
		case (state)
			2'b00: begin // OFF
				if (j)
					state <= 2'b01; // ON
				else
					state <= 2'b00; // OFF
			end
			2'b01: begin // ON
				if (k)
					state <= 2'b00; // OFF
				else
					state <= 2'b01; // ON
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'b00: out = 1'b0; // OFF
		2'b01: out = 1'b1; // ON
	endcase
end

endmodule
