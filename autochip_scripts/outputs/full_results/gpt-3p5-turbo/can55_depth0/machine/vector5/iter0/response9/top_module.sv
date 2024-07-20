module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] a_not, b_not, c_not, d_not, e_not;
    wire [24:0] a_patch, b_patch, c_patch, d_patch, e_patch;

    assign a_not = ~{a,a,a,a,a};
    assign b_not = ~{b,b,b,b,b};
    assign c_not = ~{c,c,c,c,c};
    assign d_not = ~{d,d,d,d,d};
    assign e_not = ~{e,e,e,e,e};

    assign a_patch = {a,a,a,a,a};
    assign b_patch = {b,b,b,b,b};
    assign c_patch = {c,c,c,c,c};
    assign d_patch = {d,d,d,d,d};
    assign e_patch = {e,e,e,e,e};

    assign out = a_not ^ a_patch ^ b_not ^ b_patch ^ c_not ^ c_patch ^ d_not ^ d_patch ^ e_not ^ e_patch;
    
endmodule
