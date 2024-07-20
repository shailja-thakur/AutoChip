module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire w;

submodule instance(
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .r_in(r_in),
    .Q(w)
);

always @(posedge clk) begin
    if (L) begin
        q <= r_in;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

assign Q = w;

endmodule
module submodule(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire w;

reg [2:0] q_temp;
reg [1:0] r_temp;

mux2to1 mux_inst(
    .sel(L),
    .a(q_in),
    .b(r_in),
    .out(r_temp)
);

always @(posedge clk) begin
    q_temp <= q;
    r_temp <= r_in;
end

always @(posedge clk) begin
    if (L) begin
        q <= r_in;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

assign Q = r_temp;

endmodule
module mux2to1(
    input sel,
    input a,
    input b,
    output reg out
);

always @(sel, a, b) begin
    if (sel) begin
        out <= b;
    end else begin
        out <= a;
    end
end

endmodule
