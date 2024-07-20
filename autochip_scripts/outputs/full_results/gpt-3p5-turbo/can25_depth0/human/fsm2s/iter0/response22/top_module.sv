module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out_prev;
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // OFF state
		out_prev <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // OFF state
				if (j) begin
					state <= 2'b01; // ON state
					out_prev <= 1'b1;
				end
				else begin
					state <= 2'b00; // OFF state
					out_prev <= 1'b0;
				end
			end
			2'b01: begin // ON state
				if (k) begin
					state <= 2'b00; // OFF state
					out_prev <= 1'b0;
				end
				else begin
					state <= 2'b01; // ON state
					out_prev <= 1'b1;
				end
			end
			default: begin // Default case (should not occur)
				state <= 2'b00; // OFF state
				out_prev <= 1'b0;
			end
		endcase
	end
end

assign out = out_prev;

endmodule
