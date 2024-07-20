module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Generate the first output, out_assign, using an assign statement
    assign out_assign = a & b;

    // Generate the second output, out_alwaysblock, using an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
