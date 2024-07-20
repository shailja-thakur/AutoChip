module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] vec1, vec2;

assign vec1 = {5{~a}};
assign vec2 = {5{a,b,c,d,e}};

assign out = vec1 ^ vec2;

endmodule
