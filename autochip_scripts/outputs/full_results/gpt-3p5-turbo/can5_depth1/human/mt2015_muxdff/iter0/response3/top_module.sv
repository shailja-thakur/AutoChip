module flipflop(
    input clk,
    input q_in,
    output reg Q
);
    always @(posedge clk) begin
        Q <= q_in;
    end
endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);
    always @(S, D0, D1) begin
        if (S) begin
            Y <= D1;
        end else begin
            Y <= D0;
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
    wire [2:0] submodule_q;
    wire [2:0] r;
    wire L;
    
    flipflop ff1 (
        .clk(clk),
        .q_in(q_in),
        .Q(submodule_q[0])
    );
    
    mux_2to1 mux1 (
        .S(L),
        .D0(submodule_q[0]),
        .D1(r[0]),
        .Y(Q[0])
    );
    
    flipflop ff2 (
        .clk(clk),
        .q_in(submodule_q[1]),
        .Q(submodule_q[2])
    );
    
    mux_2to1 mux2 (
        .S(L),
        .D0(submodule_q[2]),
        .D1(r[1]),
        .Y(Q[1])
    );
    
    flipflop ff3 (
        .clk(clk),
        .q_in(submodule_q[2]),
        .Q(submodule_q[1])
    );
    
    mux_2to1 mux3 (
        .S(L),
        .D0(submodule_q[1]),
        .D1(r[2]),
        .Y(Q[2])
    );
    
    assign r = r_in;
    assign L = L;
endmodule
