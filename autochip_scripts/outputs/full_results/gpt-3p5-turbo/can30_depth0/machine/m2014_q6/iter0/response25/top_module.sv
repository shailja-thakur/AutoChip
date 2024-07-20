module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000:     // State A
				begin
						if (w)
						begin
							z <= 1'b0;
							  state <= 3'b000;
						end else 
						begin
							  z <= 1'b0;
							  state <= 3'b001;
						end 
				end
				3'b001:     // State B
				begin
						if (w)
						begin
							
							z <= 1'b1;
							  	  state <= 3'b010;
						end else 
						begin
							  	z <= 1'b0;
							   state <= 3'b011;
						end
				end
				3'b010:     // State C
				begin
						if (w)
						begin
							  	z <= 1'b0;
							  	state <= 3'b100;
						end else 
						begin
								z <= 1'b1;
								  	state <= 3'b010;
						end
				end
				3'b011:     // State D
				begin
						if (w)
						begin
							  	z <= 1'b0;
							  	state <= 3'b000;
						end else 
						begin
							  	z <= 1'b0;
							  	state <= 3'b011;
						end
				end
				3'b100:     // State E
				begin
						if (w)
						begin
							  	z <= 1'b0;
							  	state <= 3'b011;
						end else 
						begin
							  	z <= 1'b1;
							  	state <= 3'b100;
						end
				end
				default:    // State F
					if (w)
						begin
							  	z <= 1'b0;
							  	state <= 3'b010;
						end else 
						begin
							  	z <= 1'b1;
							  	state <= 3'b100;
						end
			endcase
		end
	end
endmodule
