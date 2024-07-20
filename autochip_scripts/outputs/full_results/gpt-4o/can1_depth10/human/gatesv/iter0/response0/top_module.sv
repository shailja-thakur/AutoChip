module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);

    // (1) out_both: Both in[i] and in[i+1] are '1'
    assign out_both[2] = in[2] & in[3];
    assign out_both[1] = in[1] & in[2];
    assign out_both[0] = in[0] & in[1];

    // (2) out_any: Any of in[i] or in[i-1] is '1'
    assign out_any[3] = in[3] | in[2];
    assign out_any[2] = in[2] | in[1];
    assign out_any[1] = in[1] | in[0];
    
    // (3) out_different: in[i] is different from in[i-1] (wrap around for in[3])
    assign out_different[3] = in[3] ^ in[0];
    assign out_different[2] = in[2] ^ in[3];
    assign out_different[1] = in[1] ^ in[2];
    assign out_different[0] = in[0] ^ in[1];
    
endmodule
