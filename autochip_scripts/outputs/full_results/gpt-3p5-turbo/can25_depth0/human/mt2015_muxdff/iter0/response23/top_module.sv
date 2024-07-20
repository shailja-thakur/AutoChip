module flipflop(
    input clk,
    input reset,
    input D,
    output reg Q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;
        end else begin
            Q <= D;
        end
    end

endmodule
module mux_2to1(
    input a,
    input b,
    input sel,
    output reg out
);

    always @(a, b, sel) begin
        case(sel)
            2'b00: out <= a;
            2'b01: out <= b;
            default: out <= a;
        endcase
    end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire q1, q2, q3;
    wire r1, r2, r3;
    wire sel1, sel2, sel3;

    flipflop ff1(
        .clk(clk),
        .reset(1'b0),
        .D(q_in),
        .Q(q1)
    );

    flipflop ff2(
        .clk(clk),
        .reset(1'b0),
        .D(q1),
        .Q(q2)
    );

    flipflop ff3(
        .clk(clk),
        .reset(1'b0),
        .D(q2),
        .Q(q3)
    );

    mux_2to1 mux1(
        .a(q3),
        .b(r_in),
        .sel(L),
        .out(sel1)
    );

    mux_2to1 mux2(
        .a(q2),
        .b(sel1),
        .sel(L),
        .out(sel2)
    );

    mux_2to1 mux3(
        .a(q1),
        .b(sel2),
        .sel(L),
        .out(sel3)
    );

    always @(posedge clk) begin
        Q <= sel3;
    end

endmodule
