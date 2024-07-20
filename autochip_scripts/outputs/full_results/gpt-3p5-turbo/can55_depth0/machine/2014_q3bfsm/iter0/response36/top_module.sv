module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end
		else begin
			case (state)
				3'b000: begin
					if (x) begin
						state <= 3'b001;
					end
					else begin
						state <= 3'b000;
					end
				end
				
				3'b001: begin
					if (x) begin
						state <= 3'b100;
					end
					else begin
						state <= 3'b001;
					end
				end
				
				3'b010: begin
					if (x) begin
						state <= 3'b001;
					end
					else begin
						state <= 3'b010;
					end
				end
				
				3'b011: begin
					if (x) begin
						state <= 3'b010;
					end
					else begin
						state <= 3'b011;
					end
				end
				
				3'b100: begin
					if (x) begin
						state <= 3'b100;
					end
					else begin
						state <= 3'b011;
					end
				end
				
				default: state <= 3'b000;
				
			endcase
		end
	end
	
	always @(state, x) begin
		if (state == 3'b011 || state == 3'b100) begin
			z <= 1'b1;
		end
		else begin
			z <= 1'b0;
		end
	end

endmodule
