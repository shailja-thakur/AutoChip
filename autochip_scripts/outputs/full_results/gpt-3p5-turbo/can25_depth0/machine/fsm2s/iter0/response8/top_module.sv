module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00; // State A
		end else begin
			case (state)
				2'b00: begin // State A
					if (j) begin
						state <= 2'b01; // State B
					end else begin
						state <= 2'b00; // State A
					end
				end
				2'b01: begin // State B
					if (k) begin
						state <= 2'b00; // State A
					end else begin
						state <= 2'b01; // State B
					end
				end
				default: begin
					state <= 2'b00; // State A
				end
			endcase
		end
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
