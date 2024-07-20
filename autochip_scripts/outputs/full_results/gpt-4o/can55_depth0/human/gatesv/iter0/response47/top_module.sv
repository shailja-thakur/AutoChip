module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    
    // Calculate out_both: Each bit indicates if both the corresponding input bit and its neighbour to the left are '1'
    assign out_both[0] = in[0] & in[1]; 
    assign out_both[1] = in[1] & in[2];
    assign out_both[2] = in[2] & in[3];

    // Calculate out_any: Each bit indicates if any of the corresponding input bit and its neighbour to the right are '1'
    assign out_any[1] = in[1] | in[0]; 
    assign out_any[2] = in[2] | in[1];
    assign out_any[3] = in[3] | in[2];

    // Calculate out_different: Each bit indicates if the corresponding input bit is different from its neighbour to the left (wrapping around)
    assign out_different[0] = in[0] ^ in[3];
    assign out_different[1] = in[1] ^ in[0];
    assign out_different[2] = in[2] ^ in[1];
    assign out_different[3] = in[3] ^ in[2];

endmodule
