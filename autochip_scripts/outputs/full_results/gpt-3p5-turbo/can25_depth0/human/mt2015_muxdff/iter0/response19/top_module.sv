module flipflop (
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux_2to1 (
    input S, 
    input D0,
    input D1,
    output reg Q
);

    always @* begin
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

    wire mux_out1, mux_out2, mux_out3;
    wire flipflop_out1, flipflop_out2, flipflop_out3;
    
    flipflop flip1 (
        .clk(clk),
        .D(q_in),
        .Q(flipflop_out1)
    );
    
    flipflop flip2 (
        .clk(clk),
        .D(r_in),
        .Q(flipflop_out2)
    );
    
    flipflop flip3 (
        .clk(clk),
        .D(flipflop_out3),
        .Q(flipflop_out3)
    );
    
    mux_2to1 mux1 (
        .S(L),
        .D0(q_in),
        .D1(flipflop_out1),
        .Q(mux_out1)
    );
    
    mux_2to1 mux2 (
        .S(L),
        .D0(r_in),
        .D1(flipflop_out2),
        .Q(mux_out2)
    );
    
    mux_2to1 mux3 (
        .S(L),
        .D0(flipflop_out3),
        .D1(flipflop_out3),
        .Q(mux_out3)
    );
    
    assign Q = mux_out3;
    
endmodule
