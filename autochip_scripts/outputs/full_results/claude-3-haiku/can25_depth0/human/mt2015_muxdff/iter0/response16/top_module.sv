module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] q
);

    wire [2:0] q1, q2, q3;

    sub_module sub_module1 (
        .clk(clk),
        .L(L),
        .q_in(q3[0]),
        .r_in(r_in[0]),
        .Q(q1[0])
    );

    sub_module sub_module2 (
        .clk(clk),
        .L(L),
        .q_in(q1[1]),
        .r_in(r_in[1]),
        .Q(q2[1])
    );

    sub_module sub_module3 (
        .clk(clk),
        .L(L),
        .q_in(q2[2]),
        .r_in(r_in[2]),
        .Q(q3[2])
    );

    assign q = {q3[0], q2[1], q1[2]};

endmodule
module sub_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
