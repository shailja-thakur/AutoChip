module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

reg [2:0] q_int;

always @(posedge clk) begin
    if (L) begin
        q_int <= r_in;
    end else begin
        q_int <= {q_int[1] ^ q_int[2], q_int[0], q_int[2]};
    end
end

assign Q = q_int;

endmodule
