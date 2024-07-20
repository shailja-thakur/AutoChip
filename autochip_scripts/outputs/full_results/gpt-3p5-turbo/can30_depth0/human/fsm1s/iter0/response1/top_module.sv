module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b10; // B
		end else begin
			case (state)
				2'b10: begin // B state
					if (in) begin
						state <= 2'b10; // B
					end else begin
						state <= 2'b01; // A
					end
				end
				2'b01: begin // A state
					if (in) begin
						state <= 2'b01; // A
					end else begin
						state <= 2'b10; // B
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b10: begin // B state
				out <= 1'b1;
			end
			2'b01: begin // A state
				out <= 1'b0;
			end
		endcase
	end

endmodule
