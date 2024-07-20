module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign statement to generate the first output, out_assign
    assign out_assign = a & b;

    // Always block to generate the second output, out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
