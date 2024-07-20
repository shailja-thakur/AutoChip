module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign out_assign using an assign statement
    assign out_assign = a & b;

    // Assign out_alwaysblock using an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
