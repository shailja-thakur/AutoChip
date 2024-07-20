module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Using assign statement for AND gate
    assign out_assign = a & b;

    // Using combinational always block for AND gate
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
