module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

    // Generate the first output using the assign statement
    assign out_assign = a & b;
    
    // Generate the second output using an always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
