module top_module (
    input a,
    input b,
    input c, 
    input d,
    output q
);

wire ab, abc, abcd;

assign ab = a & b;
assign abc = ab & c;
assign abcd = abc & d;

assign q = abcd;

endmodule
