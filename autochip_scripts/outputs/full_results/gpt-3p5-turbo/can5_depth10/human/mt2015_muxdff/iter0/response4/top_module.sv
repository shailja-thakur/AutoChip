module flipflop(
    input clk,
    input r,
    output reg q);

    always @(posedge clk)
        q <= r;

endmodule
module mux_2to1(
    input i0,
    input i1,
    input sel,
    output reg y);

    always @*
    begin
        case (sel)
            1'b0: y <= i0;
            1'b1: y <= i1;
        endcase
    end
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire q_temp;
    wire q_temp_2;

    flipflop ff_1(clk, r_in, q_temp);
    mux_2to1 mux_1(q_in, L, q_temp, q_temp_2);
    flipflop ff_2(clk, q_temp_2, Q);

endmodule
