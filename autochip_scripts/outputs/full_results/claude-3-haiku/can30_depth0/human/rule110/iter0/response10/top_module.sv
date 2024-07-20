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
        // Compute the next state of each cell based on the Rule 110 logic
        q[0] <= (q[1] & q[2]) | (~q[1] & q[2]) | (q[1] & ~q[2]);
        for (genvar i = 1; i < 511; i++) begin
            q[i] <= (q[i-1] & q[i]) | (~q[i-1] & q[i]) | (q[i-1] & ~q[i]);
        end
        q[511] <= (q[510] & 1'b0) | (~q[510] & 1'b0) | (q[510] & 1'b0);
    end
end

endmodule
