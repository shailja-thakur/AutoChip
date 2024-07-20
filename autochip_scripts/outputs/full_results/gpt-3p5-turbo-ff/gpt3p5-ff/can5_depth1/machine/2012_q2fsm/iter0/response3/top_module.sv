module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b0;
		end else begin
			case(state)
				3'b000: begin // A state
					if (w) begin
						state <= 3'b001;
					end else begin
						state <= 3'b000;
					end
				end
				
				3'b001: begin // B state
					if (w) begin
						state <= 3'b010;
					end else begin
						state <= 3'b100;
					end
				end
				
				3'b010: begin // C state
					if (w) begin
						state <= 3'b110;
					end else begin
						state <= 3'b100;
					end
				end
				
				3'b011: begin // D state
					if (w) begin
						state <= 3'b011;
					end else begin
						state <= 3'b000;
					end
				end
				
				3'b100: begin // E state
					if (w) begin
						state <= 3'b100;
					else
						state <= 3'b010;
					end
				end
				
				3'b101: begin // F state
					if (w) begin
						state <= 3'b110;
					end else begin
						state <= 3'b011;
					end
				end
				
				default: begin
					state <= 3'b0;
				end
			endcase
		end
	end
	
	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
	
endmodule
