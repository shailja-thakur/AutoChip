module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Use assign statement for out_assign
    assign out_assign = a & b;

    // Use always block for out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
