module kmap2 (

    input [1:0] ab,
    input [1:0] cd,
    output out
);

// Implement the circuit described by the Karnaugh map

assign out = (!ab[1] & !ab[0] & cd[1]) | (!ab[1] & ab[0] & cd[1]) | (ab[1] & !ab[0] & !cd[0] & !cd[1]) | (ab[1] & !ab[0] & cd[1] & !cd[0]) | (ab[1] & !ab[0] & cd[1] & cd[0]);
  
endmodule
module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire [1:0] ab;
wire [1:0] cd;

assign ab = {a, b};
assign cd = {c, d};

kmap2 kmap_inst (
    .ab(ab),
    .cd(cd),
    .out(out)
);

endmodule
