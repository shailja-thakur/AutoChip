module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire v1, v2, v3, v4, v5, v6;

// Implement the logic based on the given simulation waveforms
assign v1 = ~(a & b & ~c & ~d);
assign v2 = a & ~b & c & ~d;
assign v3 = a & ~b & c & d;
assign v4 = ~a & b & ~c & d;
assign v5 = ~a & b & c & ~d;
assign v6 = ~a & b & c & d;

assign q = v1 | v2 | v3 | v4 | v5 | v6;

endmodule
