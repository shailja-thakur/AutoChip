module top_module(
	output reg zero);

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)
			zero <= 0;
        else
			zero <= 0;
	end
endmodule
