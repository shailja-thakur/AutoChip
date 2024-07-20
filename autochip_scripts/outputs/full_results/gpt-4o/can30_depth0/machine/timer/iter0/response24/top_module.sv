module top_module(
	input clk,
	input load,
	input [9:0] data,
	output reg tc
);

	reg [9:0] counter;

	always @(posedge clk) begin
		if (load) begin
			counter <= data;
		end else if (counter != 10'd0) begin
			counter <= counter - 10'd1;
		end
	end

	always @(counter) begin
		if (counter == 10'd0) begin
			tc = 1'b1;
		end else begin
			tc = 1'b0;
		end
	end

endmodule
