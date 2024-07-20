module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk, posedge reset) begin
    if (reset) begin
        Q <= 1'b0;
    end else begin
        Q <= D;
    end
end

endmodule
module mux_2to1(
    input S,
    input I0,
    input I1,
    output reg O
);

always @(*) begin
    if (S) begin
        O = I1;
    end else begin
        O = I0;
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

wire mux_out;
wire flipflop_out;

mux_2to1 mux_inst (
    .S(L),
    .I0(q_in),
    .I1(r_in),
    .O(mux_out)
);

flipflop flipflop_inst (
    .clk(clk),
    .D(mux_out),
    .reset(1'b0),
    .Q(flipflop_out)
);

always @(posedge clk, posedge L) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= flipflop_out;
    end
end

endmodule
