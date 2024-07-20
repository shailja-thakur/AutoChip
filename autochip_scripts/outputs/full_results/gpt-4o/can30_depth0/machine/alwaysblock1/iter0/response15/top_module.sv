module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // out_assign is driven by a continuous assignment
    assign out_assign = a & b;

    // out_alwaysblock is driven by an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
