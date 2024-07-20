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
        q <= {1'b0, q[511:1]};  // Shift right by 1 bit and add 0 at the beginning
    end
end

endmodule
