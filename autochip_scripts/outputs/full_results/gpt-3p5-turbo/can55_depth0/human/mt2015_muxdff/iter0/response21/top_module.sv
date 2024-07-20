module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= D;
    end
endmodule
module multiplexer2to1(
    input i0,
    input i1,
    input select,
    output reg out
);
    always @(*) begin
        if (select)
            out = i1;
        else
            out = i0;
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);
    wire q_temp1, q_temp2;
    wire mux_out;

    flipflop ff1(clk, q_in, L, q_temp1);
    flipflop ff2(clk, q_temp2, L, Q);
    multiplexer2to1 mux(q_temp1, r_in, L, mux_out);

    assign q_temp2 = mux_out;
endmodule
