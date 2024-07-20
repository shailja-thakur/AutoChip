module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out;

parameter OFF = 2'b00;
parameter ON = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= OFF;
		out <= 0;
	end else begin
		case(state)
			OFF: begin
				if (j) begin
					state <= ON;
					out <= 0;
				end else begin
					state <= OFF;
				end
			end
			ON: begin
				if (k) begin
					state <= OFF;
					out <= 1;
				end else begin
					state <= ON;
				end
			end
		endcase
	end
end

endmodule
