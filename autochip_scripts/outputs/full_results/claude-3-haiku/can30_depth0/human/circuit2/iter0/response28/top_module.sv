module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire ab, abc, abd, abcd;

assign ab = a & b;
assign abc = ab & c;
assign abd = ab & d;
assign abcd = abc ^ abd;

assign q = abcd;

endmodule
