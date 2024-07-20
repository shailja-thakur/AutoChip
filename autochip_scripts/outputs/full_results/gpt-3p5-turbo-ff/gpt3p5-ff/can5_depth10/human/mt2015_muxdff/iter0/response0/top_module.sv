module flipflop(input clk, input D, output reg Q);
    always @(posedge clk)
        Q <= D;
endmodule
module mux_2to1(input S, input D0, input D1, output reg Q);
    always @(S)
        if (S)
            Q <= D1;
        else
            Q <= D0;
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire [2:0] r;
    wire [2:0] q;

    flipflop flipflop1 ( .clk(clk), .D(q_in), .Q(q[0]) );
    mux_2to1 mux1 ( .S(L), .D0(r_in), .D1(q[1]), .Q(r[0]) );
    mux_2to1 mux2 ( .S(L), .D0(q[1]), .D1(q[2]), .Q(r[1]) );
    mux_2to1 mux3 ( .S(L), .D0(q[2]), .D1(q[0]^q[2]), .Q(r[2]) );

    always @(posedge clk) begin
        if (L) begin
            q <= r;
        end else begin
            q <= {q[1] ^ q[2], q[0], q[2]};
        end
    end

    assign Q = q[2];
endmodule
