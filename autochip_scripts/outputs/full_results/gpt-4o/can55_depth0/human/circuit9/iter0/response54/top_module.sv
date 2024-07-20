module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	reg [2:0] counter;

	always @(posedge clk) begin
		if (a == 1) begin
			counter <= 4;
		end else begin
			if (counter == 6) begin
				counter <= 0;
			end else begin
				counter <= counter + 1;
			end
		end
		q <= counter;
	end
	
endmodule
