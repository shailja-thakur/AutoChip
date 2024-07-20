module flipflop(
    input clk,
    input reset,
    input d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
module mux_2to1(
    input a,
    input b,
    input sel,
    output reg out
);
    always @(*) begin
        case (sel)
            1'b0: out = a;
            1'b1: out = b;
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
    wire q_int, q_out;

    flipflop flipflop_inst1 (.clk(clk), .reset(L), .d(q_in), .q(q_int));
    mux_2to1 mux_inst1 (.a(r_in), .b(q_int), .sel(L), .out(q_out));
    flipflop flipflop_inst2 (.clk(clk), .reset(L), .d(q_out), .q(Q));
endmodule
