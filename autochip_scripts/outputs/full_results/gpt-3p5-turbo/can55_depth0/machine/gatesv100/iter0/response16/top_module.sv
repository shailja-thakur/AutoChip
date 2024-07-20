module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Generate out_both signal by performing bit-wise AND operation between the two input signals
    assign out_both = in[98:0] & in[99:1];

    // Generate out_any signal by performing bit-wise OR operation between the two input signals
    assign out_any = in | in;

    // Generate out_different signal by performing bit-wise XOR operation between the two input signals
    assign out_different = {in[0] ^ in[99], in[98:1] ^ in[99:2]};
    
endmodule
