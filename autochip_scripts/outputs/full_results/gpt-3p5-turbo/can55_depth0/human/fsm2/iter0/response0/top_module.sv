module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end
		else begin
			case (state)
				0: begin // OFF state
					if (j) begin
						state <= 2'b1; // Transition to ON state
					end
					else begin
						state <= 2'b0; // Stay in OFF state
					end
				end
				1: begin // ON state
					if (k) begin
						state <= 2'b0; // Transition to OFF state
					end
					else begin
						state <= 2'b1; // Stay in ON state
					end
				end
				default: begin
					state <= 2'b0;
				end
			endcase
		end
	end

	assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
