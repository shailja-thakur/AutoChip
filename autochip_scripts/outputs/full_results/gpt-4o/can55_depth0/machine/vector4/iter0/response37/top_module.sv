module top_module (
    input [7:0] in,
    output [31:0] out
);
    // Replicating the 8-bit input 3 times to form a 24-bit value
    wire [23:0] replicated_input = {3{in}};
    
    // Concatenating the replicated 24-bit value with the original 8-bit input to form a 32-bit output
    assign out = {replicated_input, in};
endmodule
