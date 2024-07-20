module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

	// Flip-flop for state y[2]
	reg [2:0] y_ff;
	
	// 3-bit counter for state y[2:0]
	reg [2:0] y_counter;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			y_ff <= 3'b000;
			y_counter <= 3'b000;
		end
		else
		begin
			y_ff <= y_counter;
			
			case (y_ff)
				3'b000:
					begin
						if (x)
							y_counter <= 3'b001;
						else
							y_counter <= 3'b000;
						z <= 0;
					end
				3'b001:
					begin
						if (x)
							y_counter <= 3'b100;
						else
							y_counter <= 3'b001;
						z <= 0;
					end
				3'b010:
					begin
						if (x)
							y_counter <= 3'b001;
						else
							y_counter <= 3'b010;
						z <= 0;
					end
				3'b011:
					begin
						if (x)
							y_counter <= 3'b010;
						else
							y_counter <= 3'b001;
						z <= 1;
					end
				3'b100:
					begin
						if (x)
							y_counter <= 3'b100;
						else
							y_counter <= 3'b011;
						z <= 1;
					end
				default: y_counter <= 3'b000;
			endcase
		end
	end
	
	assign y = y_ff;
	
endmodule
