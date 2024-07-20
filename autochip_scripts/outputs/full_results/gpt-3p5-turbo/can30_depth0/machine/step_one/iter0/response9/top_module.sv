module top_module(
    output reg one);

    // Assign the output one to a constant value of 1'b1
    always @(*) begin
        one = 1;
    end

endmodule
