module flipflop (
    input clk, 
    input D, 
    output reg Q
);
    always @(posedge clk) 
    begin
       Q <= D;
    end
endmodule
module mux_2_1 (
    input S,
    input D0,
    input D1,
    output reg Q
);
    always @(S or D0 or D1)
    begin
        if (S == 0)
          Q <= D0;
        else 
          Q <= D1;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire reg_out;
    wire mux_out;

    flipflop ff(
        .clk(clk),
        .D(q_in),
        .Q(reg_out)
    );

    mux_2_1 mux(
        .S(L),
        .D0(q_in),
        .D1(r_in),
        .Q(mux_out)
    );

    always @(posedge clk)
    begin
        if (L)
            Q <= r_in;
        else
            Q <= mux_out;
    end
endmodule
