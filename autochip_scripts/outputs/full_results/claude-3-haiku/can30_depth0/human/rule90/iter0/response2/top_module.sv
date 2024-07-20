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
        // Implement the Rule 90 cellular automaton logic
        q[0] <= q[1];
        q[511] <= 0;
        for (int i = 1; i < 511; i++) begin
            q[i] <= q[i-1] ^ q[i+1];
        end
    end
end

endmodule
