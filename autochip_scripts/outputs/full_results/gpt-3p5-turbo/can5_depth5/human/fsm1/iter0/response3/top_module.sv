module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;
		end else begin
			case(state)
				2'b00: begin
					if (in) begin
						state <= 2'b01;
					end else begin
						state <= 2'b10;
					end
				end
				
				2'b01: begin
					if (in) begin
						state <= 2'b01;
					end else begin
						state <= 2'b10;
					end
				end
				
				2'b10: begin
					if (in) begin
						state <= 2'b00;
					end else begin
						state <= 2'b10;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			2'b00: begin
				out <= 1'b1;
			end
			
			2'b01: begin
				out <= 1'b0;
			end
			
			2'b10: begin
				out <= 1'b1;
			end
		endcase
	end
	
endmodule
