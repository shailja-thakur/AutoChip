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
        // Calculate the next state of each cell based on the Rule 110 logic
        for (int i = 0; i < 512; i++) begin
            // Handle boundary conditions
            int left = (i == 0) ? 0 : q[i-1];
            int right = (i == 511) ? 0 : q[i+1];
            q[i] <= (left & q[i] & right) | (~left & q[i] & ~right) | (left & ~q[i] & right) | (~left & ~q[i] & ~right);
        end
    end
end

endmodule
