module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q);

	always @(posedge clk) begin
		// Shift data in if shift enabled
		if (shift_ena)
			q <= {data, q[3:1]};
        
		// Decrement q if count enabled
		if (count_ena)
			q <= q - 4'b0001;
	end

endmodule
