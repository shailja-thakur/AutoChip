module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_reg;

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q_reg <= R;
        else if (Q_reg == 1'b1)
            Q_reg <= w;
        else
            Q_reg <= Q_reg;
    end
    else if (L)
        Q_reg <= 1'b0;
end

always @(posedge clk) begin
    Q <= Q_reg;
end

endmodule
module top_module_tb();

reg clk, w, R, E, L;
wire Q;

integer i;

top_module uut (
    .clk(clk),
    .w(w),
    .R(R),
    .E(E),
    .L(L),
    .Q(Q)
);

always begin
    #5 clk = ~clk;
end

initial begin
    clk = 1'b1;
    R = 1'b0;
    E = 1'b0;
    L = 1'b0;
    w = 1'b0;
    
    #10 R = 1'b1;
    #10 E = 1'b1;
    #10 L = 1'b1;
    #10 w = 1'b1;
    #10 E = 1'b0;
    #10 L = 1'b0;
    
    $finish;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule
