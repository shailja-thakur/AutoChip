module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

always @(posedge clk) begin
    if (load)
        q <= data;
    else begin
        q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0}; // Last two bits of q are XORed, and a 0 is added at the beginning of q
    end
end

endmodule
