module flipflop (
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk)
        Q <= D;
endmodule
module mux_2to1 (
    input S,
    input I0,
    input I1,
    output reg O
);
    always @(*)
    begin
        if (S)
            O <= I1;
        else
            O <= I0;
    end
endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire M0_out, M1_out, M2_out;
    wire F0_out, F1_out, F2_out;

    flipflop F0 (.clk(clk), .D(q_in), .Q(F0_out));
    flipflop F1 (.clk(clk), .D(F2_out), .Q(F1_out));
    flipflop F2 (.clk(clk), .D(F1_out), .Q(F2_out));
    
    mux_2to1 M0 (.S(L), .I0(r_in), .I1(F0_out), .O(M0_out));
    mux_2to1 M1 (.S(L), .I0(F2_out), .I1(M0_out), .O(M1_out));
    mux_2to1 M2 (.S(L), .I0(M1_out), .I1(F2_out), .O(M2_out));
    
    always @(posedge clk)
    begin
        if (L)
            Q <= r_in;
        else
            Q <= M2_out;
    end
endmodule
