module flipflop (
    input clk,
    input reset,
    input D,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule
module mux2to1 (
    input [1:0] S,
    input D0,
    input D1,
    output reg Y
);
    always @(S, D0, D1) begin
        case (S)
            2'b00: Y <= D0;
            2'b01: Y <= D1;
            2'b10: Y <= D0;
            2'b11: Y <= D1;
        endcase
    end
endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire [2:0] r;
    wire [2:0] q;
    wire q_0, q_1, q_2;

    flipflop ff0 (
        .clk(clk),
        .reset(L),
        .D(r_in[0]),
        .Q(q_0)
    );
    flipflop ff1 (
        .clk(clk),
        .reset(L),
        .D(r_in[1]),
        .Q(q_1)
    );
    flipflop ff2 (
        .clk(clk),
        .reset(L),
        .D(r_in[2]),
        .Q(q_2)
    );

    mux2to1 mux (
        .S({q_1, q_2}),
        .D0(q_0),
        .D1(q_2),
        .Y(r[0])
    );

    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    assign Q = q[0];
endmodule
