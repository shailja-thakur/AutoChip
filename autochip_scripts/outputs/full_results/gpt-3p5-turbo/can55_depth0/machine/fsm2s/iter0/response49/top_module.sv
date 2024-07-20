module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b0;
		else begin
			if (state == 2'b00)
				state <= (j == 1'b1) ? 2'b01 : 2'b00;
			else if (state == 2'b01)
				state <= (k == 1'b1) ? 2'b00 : 2'b01;
		end
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
