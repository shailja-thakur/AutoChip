module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

always @(posedge clk) begin
    if (load) begin
        q <= data; // Load data to q if load is 1
    end else begin
        q <= {q[$bits(q)-2:0], q[0]} & ~{1'b1, q[$bits(q)-1]}; // Shift q to the right and add 0 at the end
    end
end

endmodule
