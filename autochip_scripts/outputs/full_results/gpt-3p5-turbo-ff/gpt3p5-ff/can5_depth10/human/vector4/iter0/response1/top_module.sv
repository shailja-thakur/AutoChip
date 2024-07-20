module top_module (
    input [7:0] in,
    output [31:0] out
);

// Define a wire to hold the sign bit of the input number
wire sign_bit = in[7];

// Replicate the sign bit 24 times
wire [31:0] sign_extended = {24{sign_bit}, in};

// Assign the sign-extended number to the output
assign out = sign_extended;

endmodule
