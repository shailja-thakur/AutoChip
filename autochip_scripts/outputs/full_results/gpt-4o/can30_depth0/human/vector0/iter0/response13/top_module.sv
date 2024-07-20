module top_module(
    input [2:0] vec, 
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);
    
    assign outv = vec; // Output the same vector
    assign o0 = vec[0]; // Connect output o0 to the input vector's position 0
    assign o1 = vec[1]; // Connect output o1 to the input vector's position 1
    assign o2 = vec[2]; // Connect output o2 to the input vector's position 2

endmodule
