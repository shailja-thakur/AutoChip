module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			start_shifting <= 0;
		end
		else begin
			case(state)
				3'b000: if (data) state <= 3'b001;
				3'b001: if (data) state <= 3'b010;
				3'b010: if (data) state <= 3'b011;
				3'b011: begin
						if (data)
							state <= 3'b100;
						else
							state <= 3'b000;
					end 
				3'b100: if (data) state <= 3'b000;
				default: state <= 3'b000;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (state == 3'b100)
			start_shifting <= 1;
	end
endmodule
