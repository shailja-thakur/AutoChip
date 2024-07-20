module flipflop(
    input clk,
    input D,
    output reg Q
    );

    always @(posedge clk)
        Q <= D;

endmodule
module mux_2to1(
    input S,
    input A,
    input B,
    output reg Y
    );

    always @(*)
    begin
        if(S)
            Y <= B;
        else
            Y <= A;
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
    );

    wire [2:0] q_temp;

    flipflop flipflop_inst1 (
        .clk(clk),
        .D(r_in),
        .Q(q_temp[0])
    );

    flipflop flipflop_inst2 (
        .clk(clk),
        .D(q_temp[0]),
        .Q(q_temp[1])
    );

    mux_2to1 mux_inst (
        .S(L),
        .A(q_temp[1]),
        .B(q_in),
        .Y(Q)
    );

endmodule
