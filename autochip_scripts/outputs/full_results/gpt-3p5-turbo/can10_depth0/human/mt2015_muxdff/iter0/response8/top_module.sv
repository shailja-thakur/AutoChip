module flipflop(
    input clk,
    input reset,
    input d,
    output reg q
);
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            q <= 0;
        end
        else
        begin
            q <= d;
        end
    end
    
endmodule
module mux(
    input s,
    input a,
    input b,
    output reg y
);
    
    always @(a or b or s)
    begin
        if (s)
        begin
            y <= b;
        end
        else
        begin
            y <= a;
        end
    end
    
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    
    wire [2:0] q1, q2, q3;
    wire d1, d2, d3;
    
    flipflop ff1(clk, L, d1, q1);
    flipflop ff2(clk, L, d2, q2);
    flipflop ff3(clk, L, d3, q3);
    
    mux m1(L, q1, r_in, d1);
    mux m2(L, q2, r_in, d2);
    mux m3(L, q3, r_in, d3);
    
    mux final_mux(L, q1, mux(L, q2, r_in, d2), Q);
    
endmodule
