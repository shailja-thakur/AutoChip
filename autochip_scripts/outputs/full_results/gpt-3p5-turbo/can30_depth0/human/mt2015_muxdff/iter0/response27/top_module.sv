module flipflop(
    input clk,
    input L,
    input q_in,
    output reg Q);

    always @(posedge clk) begin
        if (L) begin
            Q <= q_in;
        end else begin
            Q <= q_in;
        end
    end
endmodule
module mux2to1(
    input sel,
    input D0,
    input D1,
    output reg Y);

    always @(sel, D0, D1) begin
        if (sel) begin
            Y <= D1;
        end else begin
            Y <= D0;
        end
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire [2:0] ff_q;
    wire [2:0] ff_q_next;
    reg [2:0] mux_q;

    flipflop ff1 (
        .clk(clk),
        .L(L),
        .q_in(q_in),
        .Q(ff_q[0])
    );

    flipflop ff2 (
        .clk(clk),
        .L(L),
        .q_in(ff_q[0]),
        .Q(ff_q[1])
    );

    flipflop ff3 (
        .clk(clk),
        .L(L),
        .q_in(ff_q[1]),
        .Q(ff_q[2])
    );

    mux2to1 mux (
        .sel(r_in),
        .D0(ff_q[1]),
        .D1(ff_q[2]),
        .Y(mux_q[0])
    );

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= {mux_q[0] ^ mux_q[1], mux_q[2], mux_q[1]};
        end
    end

endmodule
