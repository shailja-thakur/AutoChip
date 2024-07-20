module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	parameter B0 = 3'b000;
	parameter B1 = 3'b001;
	parameter B2 = 3'b010;
	parameter B3 = 3'b011;
	parameter Done = 3'b100;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= B0;
		end else begin
			case (state)
				B0: begin
					state <= B1;
				end
				B1: begin
					state <= B2;
				end
				B2: begin
					state <= B3;
				end
				B3: begin
					state <= Done;
				end
				default: begin
					state <= Done;
				end
			endcase
		end
	end
	
	assign shift_ena = (state == B0) || (state == B1) || (state == B2) || (state == B3);
endmodule
