module top_module(
    input [2:0] vec,
    output [2:0] outv,
    output o2,
    output o1,
    output o0
);

    assign outv = vec; // Assign outv to be the same as the input vector, vec
    assign o2 = vec[2]; // Assign o2 to be the most significant bit of vec
    assign o1 = vec[1]; // Assign o1 to be the middle bit of vec
    assign o0 = vec[0]; // Assign o0 to be the least significant bit of vec

endmodule
