module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Logical AND operation using assign statement
    assign out_assign = a & b;
    
    // Logical AND operation using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
