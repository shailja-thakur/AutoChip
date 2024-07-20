module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux_2to1(
    input [2:0] r,
    input L,
    input q0,
    input q1,
    input q2,
    output reg [2:0] q
);
    always @(r or L) begin
        if (L) begin
            q <= r;
        end else begin
            case ({q1, q0})
                2'b00: q <= {q0 ^ q2, q1, q2};
                2'b01: q <= {q0 & q2, q2, q2};
                2'b10: q <= {q2, q1 ^ q2, q2};
                2'b11: q <= {q2, q1 & q2, q2};
            endcase
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
    wire [2:0] q_tmp;

    flipflop ff (
        .clk(clk),
        .D(q_in),
        .Q(q_tmp[0])
    );

    flipflop ff1 (
        .clk(clk),
        .D(q_tmp[0]),
        .Q(q_tmp[1])
    );

    flipflop ff2 (
        .clk(clk),
        .D(q_tmp[1]),
        .Q(Q)
    );

    mux_2to1 mux (
        .r(r_in),
        .L(L),
        .q0(q_tmp[0]),
        .q1(q_tmp[1]),
        .q2(Q)
    );
endmodule
