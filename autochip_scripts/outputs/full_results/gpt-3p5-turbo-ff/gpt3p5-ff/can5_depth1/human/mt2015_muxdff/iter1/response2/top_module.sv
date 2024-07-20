module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

// Submodule: Flip Flop
reg q_ff;

always @(posedge clk) begin
    if (L) begin
        q_ff <= r_in;
    end else begin
        q_ff <= q_in;
    end
end

// Submodule: 2-1 MUX
reg Q_mux;

always @(L or q_ff or q_in) begin
    if (L) begin
        Q_mux <= r_in;
    end else begin
        Q_mux <= q_ff;
    end
end

// Output Q
always @(posedge clk) begin
    Q <= Q_mux;
end

endmodule
module testbench();

reg clk;
reg L;
reg q_in;
reg r_in;
wire Q;

top_module UUT(
    .clk(clk),
    .L(L),
    .q_in(q_in),
    .r_in(r_in),
    .Q(Q)
);

always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    L = 0;
    q_in = 0;
    r_in = 0;
    #10 L = 1;
    #10 L = 0;
    #10 q_in = 1;
    #10 r_in = 1;
    #10 q_in = 0;
    #10 r_in = 0;
    #10 $finish;
end

endmodule
