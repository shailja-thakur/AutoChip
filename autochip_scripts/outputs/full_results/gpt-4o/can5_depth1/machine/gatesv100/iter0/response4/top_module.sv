module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    assign shifted_in = {in[98:0], 1'b0}; // Shift the 'in' vector by one bit to the left
   
    assign out_both = in[98:0] & shifted_in[98:0]; // Bit-wise AND for 99 bits
    assign out_any = in | shifted_in;             // Bit-wise OR for 100 bits
    assign out_different = in ^ {shifted_in[99:1]};
    
endmodule
