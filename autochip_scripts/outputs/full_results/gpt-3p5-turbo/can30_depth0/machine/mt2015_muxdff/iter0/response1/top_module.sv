module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

always @(posedge clk) begin
    if (L == 1'b0) begin
        Q <= q_in;
    end else begin
        Q <= r_in;
    end
end

initial begin
    Q <= 1'b0;
end

endmodule
