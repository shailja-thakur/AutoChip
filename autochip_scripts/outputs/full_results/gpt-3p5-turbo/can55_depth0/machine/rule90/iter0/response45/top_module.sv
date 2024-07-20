module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

always @(posedge clk) begin

    // The operation when load is 1
    if (load)
        q <= data;
    // The input data will be loaded to the output q.

    // The operation when load is 0
    else begin
        q <= {1'b0, q[$bits(q)-2:0]};
        // The last two bits of q are shifted to the right, and a 0 is added at the beginning of q.
    end

end

endmodule
