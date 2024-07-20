module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab, ac, ad, bc, bd, cd;

// Implement the combinational logic based on the given simulation waveforms
assign ab = a & b;
assign ac = a & c;
assign ad = a & d;
assign bc = b & c;
assign bd = b & d;
assign cd = c & d;

assign q = (ab & ~(bc | bd | cd)) | (ac & ~(bd | cd)) | (ad & ~(bc | cd)) | (bc & ~(ad | cd)) | (bd & ~(ac | cd)) | (cd & ~(ab | ac | ad));

endmodule
