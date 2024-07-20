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
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin // OFF
					if (j) begin
						state <= 2'b01; // ON
					else
						state <= 2'b00; // OFF
					end
				end
				2'b01: begin // ON
					if (k) begin
						state <= 2'b00; // OFF
					else
						state <= 2'b01; // ON
					end
				end
				default: begin
					state <= 2'b00; // OFF
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b00: out = 1'b0; // OFF
			2'b01: out = 1'b1; // ON
			default: out = 1'b0; // OFF
		endcase
	end
	
endmodule
