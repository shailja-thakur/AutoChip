module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if (reset) begin // active-high synchronous reset
		state <= 2'b10; // B
		out <= 1'b1;
	end else begin
		case (state)
			2'b00: begin // A
				if (in)
					state <= 2'b01; // A
				else
					state <= 2'b10; // B
				out <= 1'b0;
			end
			2'b01: begin // B
				if (in)
					state <= 2'b01; // B
				else
					state <= 2'b10; // A
				out <= 1'b1;
			end
			default: begin // should not reach here
				state <= 2'b10; // B
				out <= 1'b1;
			end
		endcase
	end
end

endmodule
