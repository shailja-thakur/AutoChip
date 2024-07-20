module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Implement AND gate using assign statement
    assign out_assign = a & b;

    // Implement AND gate using combinational always block
    always @(a, b) begin
        out_alwaysblock = a & b;
    end

endmodule
