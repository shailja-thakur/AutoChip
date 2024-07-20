module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0] sum_ext;

    assign sum_ext = {a[7], a} + {b[7], b};
    assign s = sum_ext[7:0];
    
    // Overflow occurs if the carry into the sign bit differs from the carry out of the sign bit
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);
    
endmodule
