module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire temp;

assign temp = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d);

assign out_sop = ~temp;

assign out_pos = a | b | c | d;
endmodule
