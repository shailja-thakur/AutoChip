module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire [3:0] inputs;
assign inputs = {a, b, c, d};

// Perform the XOR operation on the inputs
wire xor_result;
assign xor_result = ^inputs;

// Invert the XOR result to obtain the desired logic function
assign q = ~xor_result;

endmodule
