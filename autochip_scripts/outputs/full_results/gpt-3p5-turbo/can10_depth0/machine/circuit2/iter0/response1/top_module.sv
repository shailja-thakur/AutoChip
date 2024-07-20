module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire [3:0] xor_result;
wire xor_output;

assign xor_result = {a, b, c, d}; // concatenates the input signals
assign xor_output = ^xor_result; // performs XOR operation on xor_result

assign q = ~xor_output; // inverts the xor_output

endmodule
