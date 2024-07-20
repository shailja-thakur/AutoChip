module top_module(
    input [2:0] vec, 
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
    // Assign the input vector to the output vector
    assign outv = vec;
    
    // Split the input vector into individual bits
    assign o0 = vec[0];
    assign o1 = vec[1];
    assign o2 = vec[2];
    
endmodule
