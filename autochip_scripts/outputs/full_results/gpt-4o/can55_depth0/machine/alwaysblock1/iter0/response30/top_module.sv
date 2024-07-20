module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Logical AND operation assigned directly to out_assign
    assign out_assign = a & b;

    // Logical AND operation assigned to out_alwaysblock using always block
    always @(*)
    begin
        out_alwaysblock = a & b;
    end

endmodule
