module top_module (
    input clk,
    input x,
    output z
);

    reg d1, d2, d3;
    wire qx1, qx2, qx3;
    wire qx1_complement, qx2_complement, qx3_complement;
    
    xor_gate xor1(.a(d1), .b(qx1), .z(qx1_complement));
    and_gate and1(.a(d2), .b(qx2_complement), .z(qx2));
    or_gate or1(.a(d3), .b(qx3_complement), .z(qx3));
    xnor_gate xnor1(.a(qx1), .b(qx2), .c(qx3), .z(z));
    
    always @(posedge clk) begin
        d1 <= x ^ qx1;
        d2 <= ~qx2;
        d3 <= ~qx3;
    end
    
endmodule
module xor_gate (
    input a,
    input b,
    output z
);
    assign z = a ^ b;
endmodule
module and_gate (
    input a,
    input b,
    output z
);
    assign z = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output z
);
    assign z = a | b;
endmodule
module xnor_gate (
    input a,
    input b,
    input c,
    output z
);
    assign z = ~(a ^ b ^ c);
endmodule
