module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Combinational logic using assign statement
    assign out_assign = a & b;

    // Combinational logic using always block
    always @(a, b) begin
        out_alwaysblock = a & b;
    end

endmodule
