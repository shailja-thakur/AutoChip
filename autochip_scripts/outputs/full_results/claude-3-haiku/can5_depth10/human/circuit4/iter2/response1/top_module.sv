module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire tmp1, tmp2, tmp3, tmp4;

// Corrected the combinational logic
assign tmp1 = ~(a | b);
assign tmp2 = ~(c | d);
assign tmp3 = a | b;
assign tmp4 = tmp1 & tmp2;
assign q = tmp3 | tmp4;

endmodule
