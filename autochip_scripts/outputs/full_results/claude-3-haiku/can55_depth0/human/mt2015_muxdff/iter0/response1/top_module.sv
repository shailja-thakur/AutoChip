module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= {Q[1] ^ Q[2], Q[0], Q[2]};
        end
    end

endmodule
module full_module(
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

    top_module sub_module1 (
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r),
        .Q(q)
    );

    top_module sub_module2 (
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r),
        .Q(q)
    );

    top_module sub_module3 (
        .clk(clk),
        .L(L),
        .q_in(q),
        .r_in(r),
        .Q(q)
    );

endmodule
