module top_module(
	output reg one);

    // assign output one to a constant value of 1'b1
    always @(*) begin
        one = 1'b1;
    end

endmodule
