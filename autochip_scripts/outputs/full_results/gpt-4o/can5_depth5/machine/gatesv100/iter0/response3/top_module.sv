module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
); 

    // Define the shifted version of the input signal
    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], 1'b0};

    // Generate the out_both signal by performing a bit-wise AND operation
    assign out_both = in[99:1] & in[98:0];

    // Generate the out_any signal by performing a bit-wise OR operation
    assign out_any = in | in_shifted;

    // Generate the out_different signal by performing a bit-wise XOR operation
    assign out_different = in ^ in_shifted;

endmodule
