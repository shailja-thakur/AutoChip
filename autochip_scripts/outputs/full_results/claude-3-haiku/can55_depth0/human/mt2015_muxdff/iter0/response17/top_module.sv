module top_module(
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

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
