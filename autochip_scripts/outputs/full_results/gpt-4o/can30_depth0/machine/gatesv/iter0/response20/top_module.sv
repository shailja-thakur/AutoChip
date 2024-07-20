module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,      // Fixed width: [3:0] instead of [3:1]
    output [3:0] out_different
);
    assign out_both = in[2:0] & in[3:1];
    assign out_any = {in[3] | in[3], in[2] | in[2], in[1] | in[1], in[0] | in[0]}; // Vertical merge
    assign out_different = in ^ {in[3], in[3:1]};
endmodule
