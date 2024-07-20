module flipflop_mux (
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
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_in;  // Wires to connect the output of flipflop_mux to its next input
    
    // Generate the input for next stage of flipflop_mux
    assign q_in[0] = q[1] ^ q[2];
    assign q_in[1] = q[0];
    assign q_in[2] = q[2];

    // Instantiate flipflop_mux three times
    flipflop_mux u0 (.clk(clk), .L(L), .q_in(q_in[0]), .r_in(r[0]), .Q(q[0]));
    flipflop_mux u1 (.clk(clk), .L(L), .q_in(q_in[1]), .r_in(r[1]), .Q(q[1]));
    flipflop_mux u2 (.clk(clk), .L(L), .q_in(q_in[2]), .r_in(r[2]), .Q(q[2]));
endmodule
