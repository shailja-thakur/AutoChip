module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load)
        q <= data;
    else begin
        q <= {0, q[511:1]};  // shift right and add 0 at the end
    end
end

endmodule
