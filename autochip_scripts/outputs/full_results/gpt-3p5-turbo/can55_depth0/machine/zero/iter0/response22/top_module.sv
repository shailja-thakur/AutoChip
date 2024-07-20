module top_module(
	output reg zero);

    // Assigning the output zero to 0
    always @(posedge clk) begin
        zero <= 0;
    end

endmodule
