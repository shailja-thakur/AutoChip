module top_module (
    input [255:0] in,
    input [7:0] sel,
    output  out
);
    
    assign out = in[sel]; // Selecting the bit from the input vector based on the selection vector
   
endmodule
