module top_module (
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
