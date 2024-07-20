module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk or posedge reset) begin
    if(reset)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule
module mux21(
    input [1:0] D,
    input sel,
    output reg Y
);

always @(*) begin
    case (sel)
        2'b00: Y <= D[0];
        2'b01: Y <= D[1];
        default: Y <= 1'b0;
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

wire [2:0] r;
wire [2:0] q_next;

assign r = r_in;
assign q_next = (L) ? r : {Q[1] ^ Q[2], Q[0], Q[2]};

flipflop ff0 (
    .clk(clk),
    .D(q_in),
    .reset(L),
    .Q(Q)
);

mux21 mux1 (
    .D({q_in, q_next[0]}),
    .sel(r[0]),
    .Y(q_next[1])
);

mux21 mux2 (
    .D({q_in, q_next[0]}),
    .sel(r[1]),
    .Y(q_next[2])
);

mux21 mux3 (
    .D({q_in, q_next[0]}),
    .sel(r[2]),
    .Y(Q[2])
);

endmodule
