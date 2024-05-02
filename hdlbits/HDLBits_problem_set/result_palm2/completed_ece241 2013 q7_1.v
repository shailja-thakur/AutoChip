module top_module (
    input clk,
    input j,
    input k,
    output Q);

    D-type flip-flop FF1 (
        input clk,
        input D,
        output Q,
        output Q_n);

    AND gate AND1 (
        input j,
        input k,
        output Jk);

    NOT gate NOT1 (
        input Qold,
        output ~Qold);

    OR gate OR1 (
        input Jk,
        input ~Qold,
        output Q);

    assign Q = OR1.Y;

endmodule