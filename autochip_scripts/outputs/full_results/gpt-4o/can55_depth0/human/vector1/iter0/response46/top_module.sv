module top_module (
    input [15:0] in,
    output [7:0] out_hi,
    output [7:0] out_lo
);
    // Assign the lower byte
    assign out_lo = in[7:0];
    
    // Assign the upper byte
    assign out_hi = in[15:8];
    
endmodule
