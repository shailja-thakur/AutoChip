module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

module flipflop_mux (
    input clk,
    input L,
    input d,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= d;
    end
end

endmodule
