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
        q <= {1'b0, q[$bits(q)-1:1]}; // shift right with a 0 at the MSB
    end
end

endmodule
