module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    assign shifted_in = {in[98:0], 1'b0}; // Shift in to the right by 1
    
    // Generate out_both by ANDing in and shifted_in
    assign out_both = in[99:1] & in[98:0];
    
    // Generate out_any by ORing in and shifted_in
    assign out_any = in | shifted_in;
    
    // Generate out_different by XORing in and shifted_in
    assign out_different = {in[0] ^ in[99], in[99:1] ^ shifted_in[99:1]};
    
endmodule
