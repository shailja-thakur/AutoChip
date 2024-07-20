module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire tmp1, tmp2, tmp3, tmp4, tmp5;

// Implement the combinational logic
assign tmp1 = ~a;
assign tmp2 = ~b;
assign tmp3 = c & d;
assign tmp4 = tmp1 & tmp2 & tmp3;
assign tmp5 = a & b;
assign q = tmp5 | tmp4;

endmodule
