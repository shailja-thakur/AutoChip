module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    // Perform logical AND operation
    out_and = (in == 100'b0) ? 1'b0 : 1'b1;
    
    // Perform logical OR operation
    out_or = (in == 100'b0) ? 1'b0 : 1'b1;
    
    // Perform logical XOR operation
    out_xor = ^in;
end

endmodule
