module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Define internal wires
    wire [98:0] in_shifted;
    wire [98:0] in_reversed;
    wire [98:0] shifted_in_left;
    
    // Shift input to the right by 1 bit
    assign in_shifted = {in[98:0], 1'b0};
    
    // Reverse the input
    assign in_reversed = in[98:0];
    
    // Shift input to the left by 1 bit
    assign shifted_in_left = {1'b0, in[99:1]};
    
    // Calculate out_both
    assign out_both = in[98:0] & in_shifted;
    
    // Calculate out_any
    assign out_any = in | shifted_in_left;
    
    // Calculate out_different
    assign out_different = in[98:0] ^ in_reversed;
    
endmodule
