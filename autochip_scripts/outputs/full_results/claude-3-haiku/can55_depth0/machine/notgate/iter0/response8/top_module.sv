module top_module(
    input in,
    output reg out
);

    // Assign the inverted value of the input to the output
    always @(*) begin
        out = ~in;
    end

endmodule
