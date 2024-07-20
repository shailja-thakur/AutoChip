module flipflop(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
module mux2to1 (
    input [1:0] x,
    input S,
    output Z
);
    assign Z = (S == 1'b0) ? x[0] : x[1];
endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

    wire Mux1_out;
    wire [2:0] Flipflop1_out;
    wire [2:0] Flipflop2_out;
    wire [2:0] Flipflop3_out;

    flipflop FF1 (.clk(clk), .D(q_in), .Q(Flipflop1_out));
    flipflop FF2 (.clk(clk), .D(Flipflop1_out[1]^Flipflop1_out[2]), .Q(Flipflop2_out));
    flipflop FF3 (.clk(clk), .D(Flipflop2_out[1]^Flipflop2_out[2]), .Q(Flipflop3_out));

    mux2to1 Mux1 (.x({Flipflop3_out[1]^Flipflop3_out[2], Flipflop3_out[0]}), .S(L), .Z(Mux1_out));

    always @(posedge clk) begin
        if (L) begin
            Q <= r_in;
        end else begin
            Q <= Mux1_out;
        end
    end

endmodule
