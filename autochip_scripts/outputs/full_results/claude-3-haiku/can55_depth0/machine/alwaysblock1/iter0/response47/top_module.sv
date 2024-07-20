module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign out_assign using the assign statement
    assign out_assign = a & b;

    // Assign out_alwaysblock using the always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
