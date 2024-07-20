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
        // Compute the next state of each cell
        for (int i = 0; i < 512; i++) begin
            int left = (i == 0) ? 0 : q[i-1];
            int center = q[i];
            int right = (i == 511) ? 0 : q[i+1];
            q[i] <= (left & center & right) | (left & ~center & right) | (~left & center & right) | (~left & ~center & ~right);
        end
    end
end

endmodule
