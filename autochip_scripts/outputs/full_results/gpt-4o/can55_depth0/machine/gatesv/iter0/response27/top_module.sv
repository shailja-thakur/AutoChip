module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);
    assign out_both = in[2:0] & in[3:1];
    assign out_any = {in[2:0] | in[3:1], 1'b0}; // Adding a 0 to match the 4-bit output size
    assign out_different = in ^ {in[3:1], in[0]}; // XOR of the input vector with input[3:1] and input[0] as an exception
endmodule
