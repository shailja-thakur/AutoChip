module flipflop (
    input clk,
    input r,
    output reg q);

    always @(posedge clk) begin
        if (r) begin
            q <= 0;
        end else begin
            q <= q;
        end
    end

endmodule
module mux (
    input [1:0] sel,
    input a,
    input b,
    output reg out);

    always @(*) begin
        case (sel)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = 0;
            2'b11: out = 1;
        endcase
    end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    wire q_out1, q_out2, q_out3;

    flipflop ff1 (
        .clk(clk),
        .r(r_in),
        .q(q_out1)
    );

    flipflop ff2 (
        .clk(clk),
        .r(q_out2),
        .q(q_out3)
    );

    mux m1 (
        .sel(q_in[1:0]),
        .a(q_out1),
        .b(q_out2),
        .out(Q)
    );

endmodule
