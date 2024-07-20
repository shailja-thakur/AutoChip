module flipflop (
    input clk,
    input R,
    output reg Q
);

    always @(posedge clk) begin
        if (R) begin
            Q <= 0;
        end else begin
            Q <= ~Q;
        end
    end

endmodule
module mux_2to1 (
    input I0,
    input I1,
    input S,
    output reg Y
);

    always @(I0, I1, S) begin
        if (S) begin
            Y <= I1;
        end else begin
            Y <= I0;
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

    wire [2:0] r;
    wire [2:0] q_out;

    flipflop ff1 (
        .clk(clk),
        .R(r_in),
        .Q(q_out[0])
    );

    flipflop ff2 (
        .clk(clk),
        .R(r_in),
        .Q(q_out[1])
    );

    flipflop ff3 (
        .clk(clk),
        .R(r_in),
        .Q(q_out[2])
    );

    mux_2to1 mux (
        .I0(q_out[0]),
        .I1(q_out[1]),
        .S(q_out[2]),
        .Y(Q)
    );

    always @(posedge clk) begin
        if (L) begin
            r <= r_in;
        end else begin
            r <= {r[1] ^ r[0], r_in, r[2]};
        end
    end

endmodule
