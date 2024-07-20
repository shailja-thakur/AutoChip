module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // AND gate using an assign statement
    assign out_assign = a & b;

    // AND gate using a combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
