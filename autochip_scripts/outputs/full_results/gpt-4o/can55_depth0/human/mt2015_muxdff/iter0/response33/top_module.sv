module mux_ff(
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
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);
    wire [2:0] q_mux;
    
    // Cascade the mux_ff submodules
    mux_ff ff0 (
        .clk(clk),
        .L(L),
        .q_in(q_mux[0]),
        .r_in(r[0]),
        .Q(q[0])
    );
    
    mux_ff ff1 (
        .clk(clk),
        .L(L),
        .q_in(q[2]),
        .r_in(r[1]),
        .Q(q[1])
    );
    
    mux_ff ff2 (
        .clk(clk),
        .L(L),
        .q_in(q[1] ^ q[2]),
        .r_in(r[2]),
        .Q(q[2])
    );
    
    assign q_mux = {q[2], q[1], q[0]};
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    full_module inst (
        .clk(clk),
        .L(L),
        .r(r),
        .q(q)
    );
endmodule
