module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);
    
    // output assignment using 'assign' statement
    assign out_assign = a & b;
    
    // output assignment using 'always' block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
