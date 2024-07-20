module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute the next state for each cell based on the Rule 110 table
        q[511:1] <= {q[510:0], 1'b0};
        q[0] <= (q[1] & q[0]) | (~q[1] & q[0]) | (q[1] & ~q[0]);
    end
end

endmodule
