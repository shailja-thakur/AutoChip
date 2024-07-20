module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    // When load is 1, load the input data into q
    if (load)
        q <= data;
    else begin
        // Shift the output q to the right and add a 0 at the end
        q <= {1'b0, q[511:1]};
    end
end

endmodule
