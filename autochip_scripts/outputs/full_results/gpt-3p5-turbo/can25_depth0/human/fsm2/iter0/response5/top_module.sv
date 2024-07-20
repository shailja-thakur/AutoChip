module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg out;
reg [1:0] state;
wire reset;

assign reset = ~areset;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0; // OFF state
		out <= 1'b0;
	end else begin
		case (state)
			2'b00: begin // OFF state
				if (j) begin
					state <= 2'b01; // Transition to ON state
					out <= 1'b0;
				end
			end
			2'b01: begin // ON state
				if (k) begin
					state <= 2'b00; // Transition to OFF state
					out <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
