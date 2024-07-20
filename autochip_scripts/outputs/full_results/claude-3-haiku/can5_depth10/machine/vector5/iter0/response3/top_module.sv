module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [4:0] temp1, temp2;

assign temp1 = {5{~a}};
assign temp2 = {5{a, b, c, d, e}};

assign out = temp1 ^ temp2;

endmodule
