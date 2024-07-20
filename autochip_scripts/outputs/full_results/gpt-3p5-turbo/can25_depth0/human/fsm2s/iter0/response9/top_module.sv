module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b0; // initial state is OFF
		end else begin
			case (state)
				2'b00: begin // OFF
					if (j) begin
						state <= 2'b01; // transition to ON
					end else begin
						state <= 2'b00; // remain in OFF
					end
				end
				2'b01: begin // ON
					if (k) begin
						state <= 2'b00; // transition to OFF
					end else begin
						state <= 2'b01; // remain in ON
					end
				end
				default: begin
					state <= 2'b0;
				end
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
