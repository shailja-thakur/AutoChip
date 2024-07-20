module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:1] shifted_in;
    
    // Shift the input signal by one bit to the right
    assign shifted_in = in[98:0];

    // Generate out_both signal
    assign out_both = in[99:1] & shifted_in;

    // Generate out_any signal
    assign out_any = in | ({shifted_in, 1'b0});

    // Generate out_different signal
    assign out_different = in ^ ({shifted_in, in[99]});

endmodule
