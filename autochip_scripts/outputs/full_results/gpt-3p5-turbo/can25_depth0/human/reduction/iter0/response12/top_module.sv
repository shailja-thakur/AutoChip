module top_module (
    input [7:0] in,
    output parity
);
    // Internal wire for computing the parity bit
    wire parity_bit;
    
    // Parity checking logic
    assign parity_bit = ^in;
    
    // Output the computed parity bit
    assign parity = parity_bit;
    
endmodule
