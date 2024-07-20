module top_module (
    input [2:0] in,
    output [1:0] out
);

    assign out[1] = in[2] + in[1] + in[0]; // Calculate the sum of the three input bits and assign it to the most significant bit of the output
    assign out[0] = in[1] + in[0]; // Calculate the sum of the two least significant input bits and assign it to the least significant bit of the output
    
endmodule
