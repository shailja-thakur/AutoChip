module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 32'h1;
    end
    else begin
        q <= {q[0], q[31:23], q[21:3], q[1]};
        q[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
    end
end

endmodule
