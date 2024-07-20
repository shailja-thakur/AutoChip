module flipflop (
    input clk,
    input D,
    input reset,
    output reg Q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
        end
    end

endmodule
module mux_2to1 (
    input A,
    input B,
    input Sel,
    output reg Out
);

    always @(*) begin
        if (Sel) begin
            Out <= B;
        end else begin
            Out <= A;
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

    wire f0_Q, f1_Q, f2_Q;
    wire m0_Out, m1_Out, m2_Out;

    flipflop f0 (
        .clk(clk),
        .D(q_in),
        .reset(L),
        .Q(f0_Q)
    );

    flipflop f1 (
        .clk(clk),
        .D(f0_Q),
        .reset(L),
        .Q(f1_Q)
    );

    flipflop f2 (
        .clk(clk),
        .D(f1_Q),
        .reset(L),
        .Q(f2_Q)
    );

    mux_2to1 m0 (
        .A(f2_Q),
        .B(r_in),
        .Sel(L),
        .Out(m0_Out)
    );

    mux_2to1 m1 (
        .A(m0_Out),
        .B(f1_Q),
        .Sel(L),
        .Out(m1_Out)
    );

    mux_2to1 m2 (
        .A(m1_Out),
        .B(f2_Q),
        .Sel(L),
        .Out(m2_Out)
    );

    assign Q = m2_Out;

endmodule
