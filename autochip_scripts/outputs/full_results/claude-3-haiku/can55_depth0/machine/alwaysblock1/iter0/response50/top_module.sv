module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Output out_assign is assigned the logical AND of a and b
    assign out_assign = a & b;

    // Output out_alwaysblock is assigned the logical AND of a and b in an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
