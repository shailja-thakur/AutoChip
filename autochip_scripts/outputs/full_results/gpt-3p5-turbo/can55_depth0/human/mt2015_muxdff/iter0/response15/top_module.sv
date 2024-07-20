module flipflop(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= q_in;
        end
    end

endmodule
module multiplexer_2to1(
    input [1:0] r,
    input L,
    output reg q
);

    always @(r or L) begin
        if (L) begin
            q <= r[1];
        end else begin
            q <= r[0];
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
    wire [2:0] q_temp;

    flipflop ff_1(.clk(clk), .L(L), .q_in(q_in), .r_in(r_in), .Q(q_temp[0]));
    multiplexer_2to1 mux_1(.r(r[1:0]), .L(L), .q(q_temp[1]));
    multiplexer_2to1 mux_2(.r(r[2:1]), .L(L), .q(q_temp[2]));
    flipflop ff_2(.clk(clk), .L(L), .q_in(q_temp[1]), .r_in(q_temp[0]), .Q(q_temp[3]));
    flipflop ff_3(.clk(clk), .L(L), .q_in(q_temp[2]), .r_in(q_temp[3]), .Q(Q));

endmodule
