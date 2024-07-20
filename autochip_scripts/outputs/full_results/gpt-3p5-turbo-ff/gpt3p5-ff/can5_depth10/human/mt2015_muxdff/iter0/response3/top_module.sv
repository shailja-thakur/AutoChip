module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    reg [2:0] r;
    wire [2:0] q;

    full_module submodule (
        .r(r),
        .L(L),
        .clk(clk),
        .q(q)
    );

    reg [1:0] select;
    wire q0, q1;

    always @(*) begin
        if (select == 2'b00) begin
            q = q0;
        end else if (select == 2'b01) begin
            q = q1;
        end else begin
            q = q_in;
        end
    end

    assign Q = q;

    flipflop flipflop0 (
        .clk(clk),
        .D(r_in),
        .Q(q0)
    );

    flipflop flipflop1 (
        .clk(clk),
        .D(~r_in),
        .Q(q1)
    );

    mux21 mux (
        .a(q0),
        .b(q1),
        .s(select[0]),
        .y(q_in)
    );

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

endmodule
module flipflop(
    input clk,
    input D,
    output reg Q
);

    always @(posedge clk) begin
        Q <= D;
    end

endmodule
module mux21(
    input a,
    input b,
    input s,
    output reg y
);

    always @(*) begin
        if (s) begin
            y = b;
        end else begin
            y = a;
        end
    end

endmodule
