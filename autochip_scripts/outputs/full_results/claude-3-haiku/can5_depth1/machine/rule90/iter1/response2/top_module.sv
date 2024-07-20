module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= {q[510:0], 1'b0}; // Shift right by 1 bit and add 0 at the end
end

endmodule
