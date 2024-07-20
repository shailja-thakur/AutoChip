module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

    reg [2:0] q;

    always @(posedge clk) begin
        if (L) begin
            q <= r_in;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    assign Q = q;

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

    top_module u1 (
        .clk(clk),
        .L(L),
        .r_in(r),
        .Q(q)
    );

    top_module u2 (
        .clk(clk),
        .L(L),
        .r_in(r),
        .Q(q)
    );

    top_module u3 (
        .clk(clk),
        .L(L),
        .r_in(r),
        .Q(q)
    );

endmodule
