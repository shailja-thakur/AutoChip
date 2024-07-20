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
		state <= 2'b00; // reset state B
		out <= 1'b1;
	end else begin
		case(state)
			2'b00: begin // state B
				if (in)
					state <= 2'b00;
				else
					state <= 2'b01;
					out <= 1'b1;
			end
			
			2'b01: begin // state A
				if (in)
					state <= 2'b01;
				else
					state <= 2'b00;
					out <= 1'b0;
			end
		endcase
	end
end

endmodule
