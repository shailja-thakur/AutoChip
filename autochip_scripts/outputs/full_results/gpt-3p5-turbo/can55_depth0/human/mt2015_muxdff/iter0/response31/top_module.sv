module flipflop (
    input clk,
    input r,
    output reg q
);

always @(posedge clk)
begin
    if (r)
        q <= 1'b0;
    else
        q <= 1'b1;
end

endmodule
module mux_2_1 (
    input i0,
    input i1,
    input sel,
    output reg out
);

always @(i0, i1, sel)
begin
    if (sel)
        out <= i1;
    else
        out <= i0;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire [2:0] q;

    flipflop ff0 (
        .clk(clk),
        .r(r_in),
        .q(q[0])
    );

    flipflop ff1 (
        .clk(clk),
        .r(r_in),
        .q(q[1])
    );

    flipflop ff2 (
        .clk(clk),
        .r(r_in),
        .q(q[2])
    );

    mux_2_1 mux (
        .i0(q[1] ^ q[2]),
        .i1(q[0]),
        .sel(q[2]),
        .out(Q)
    );

    always @(posedge clk)
    begin
        if (L)
        begin
            q <= r_in;
        end
        else
        begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

endmodule
