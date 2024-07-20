module flipflop_mux (
    input clk,
    input L,
    input d,
    input r,
    output reg q
);
    always @(posedge clk) begin
        if (L) 
            q <= r;
        else 
            q <= d;
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

    // Internal signals for `d` inputs of each flipflop_mux instance
    wire d0, d1, d2;

    // Logic for `d` inputs of each flipflop_mux instance
    assign d0 = q[1] ^ q[2];
    assign d1 = q[0];
    assign d2 = q[2];

    // Instantiating three flipflop_mux submodules
    flipflop_mux u0 (.clk(clk), .L(L), .d(d0), .r(r[0]), .q(q[0]));
    flipflop_mux u1 (.clk(clk), .L(L), .d(d1), .r(r[1]), .q(q[1]));
    flipflop_mux u2 (.clk(clk), .L(L), .d(d2), .r(r[2]), .q(q[2]));

endmodule
