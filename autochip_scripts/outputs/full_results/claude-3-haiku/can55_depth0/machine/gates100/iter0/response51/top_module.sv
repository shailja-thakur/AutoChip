module top_module (
    input [99:0] in,
    output reg out_and,
    output reg out_or,
    output reg out_xor
);

always @(*) begin
    // Perform the AND operation
    out_and = &in;
    
    // Perform the OR operation
    out_or = |in;
    
    // Perform the XOR operation
    out_xor = ^in;
end

endmodule
