module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 4'b0000;
		else begin
			case (state)
				4'b0000: begin
					if (data)
						state <= 4'b0001;
					else
						state <= 4'b0000;
				end
				
				4'b0001: begin
					if (data)
						state <= 4'b0011;
					else
						state <= 4'b0000;
				end
				
				4'b0011: begin
					if (data)
						state <= 4'b0011;
					else
						state <= 4'b0110;
				end
				
				4'b0110: begin
					if (data)
						state <= 4'b1111;
					else
						state <= 4'b0000;
				end
				
				default: state <= state;
			endcase
		end
	end
	
	always @(state) begin
		if (state == 4'b1111)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end
	
endmodule
