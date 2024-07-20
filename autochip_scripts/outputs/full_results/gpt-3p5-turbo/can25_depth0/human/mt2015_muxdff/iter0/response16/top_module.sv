module flipflop(
    input clk,
    input r,
    input L,
    output reg q);
    
    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end
    end
    
endmodule
module mux_2to1(
    input a,
    input b,
    input sel,
    output reg out);
    
    always @* begin
        if (sel)
            out = b;
        else
            out = a;
    end
    
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);
    
    wire q1, q2, q3;
    wire mux_out1, mux_out2, mux_out3;
    
    flipflop ff1(clk, r_in, L, q1);
    flipflop ff2(clk, q1, L, q2);
    flipflop ff3(clk, q2, L, q3);
    
    mux_2to1 mux1(q1, r_in, L, mux_out1);
    mux_2to1 mux2(q2, q_in, L, mux_out2);
    mux_2to1 mux3(q3, mux_out2, L, mux_out3);
    
    assign Q = mux_out3;
    
endmodule
