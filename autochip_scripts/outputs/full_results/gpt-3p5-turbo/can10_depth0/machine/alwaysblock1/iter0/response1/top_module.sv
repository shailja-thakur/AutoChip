module top_module(
    input a,
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    assign out_assign = a & b; // Logical AND operation using an assign statement

    always @* begin // always block triggered whenever any of the variables in the sensitivity list changes
        out_alwaysblock = a & b; // Logical AND operation inside the always block
    end

endmodule
