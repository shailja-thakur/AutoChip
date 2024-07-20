module top_module(
	output reg one);

	always @(*) begin
		one = 1'b1;
	end

	initial begin
		$display("Output one = %b", one);
	end
endmodule
