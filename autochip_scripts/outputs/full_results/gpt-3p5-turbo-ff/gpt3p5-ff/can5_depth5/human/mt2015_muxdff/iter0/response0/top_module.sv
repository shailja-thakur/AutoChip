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
module mux (
    input [1:0] sel,
    input D0,
    input D1,
    output reg Q
);

always @ (sel)
    case (sel)
        2'b00: Q = D0;
        2'b01: Q = D1;
        2'b10: Q = D0;
        2'b11: Q = D1;
    endcase
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

    wire q0, q1, q2;
    wire [1:0] sel;
    reg r;
    reg q;

    assign sel = {L, L};
    assign q_in = q;

    flipflop ff0(
        .clk(clk),
        .reset(L),
        .D(r_in),
        .Q(q0)
    );

    flipflop ff1(
        .clk(clk),
        .reset(L),
        .D(q_in),
        .Q(q1)
    );

    mux m(
        .sel(sel),
        .D0(q0),
        .D1(q1),
        .Q(q2)
    );

    always @(posedge clk) begin
        r <= r_in;
        q <= q2;
        Q <= q;
    end

endmodule
