module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Assign statement to implement AND gate
    assign out_assign = a & b;

    // Combinational always block to implement AND gate
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
