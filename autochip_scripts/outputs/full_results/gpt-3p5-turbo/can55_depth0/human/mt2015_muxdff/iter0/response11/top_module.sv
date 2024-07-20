module flipflop (
    input clk,
    input D,
    input reset,
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
module mux (
    input I0,
    input I1,
    input S,
    output reg Y
    );

    always @ (I0, I1, S) begin
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

    reg [2:0] r;
    reg [2:0] q;
    wire sel;

    assign sel = L;

    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    flipflop flipflop1 (
        .clk(clk),
        .D(q_in),
        .reset(sel),
        .Q(Q)
        );

    mux mux1 (
        .I0(r_in),
        .I1(Q),
        .S(L),
        .Y(r)
        );

endmodule
