module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire [3:0] in = {a, b, c, d};

// SOP (Sum-of-Products) form
assign out_sop = (in == 4'b0010) | (in == 4'b0111) | (in == 4'b1111);

// POS (Product-of-Sums) form
assign out_pos = ~(((a & ~b) | (~a & b)) & ((b & ~c) | (~b & c)) & ((c & ~d) | (~c & d)));

endmodule
