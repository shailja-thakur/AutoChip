module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_state;
    end
end

always @(*) begin
    next_state = 0;
    for (int i = 0; i < 256; i++) begin
        int count = 0;
        // Calculate the number of live neighbors for each cell
        if (i % 16 != 0)    count += q[i-1];   // Left neighbor
        if (i % 16 != 15)   count += q[i+1];   // Right neighbor
        if (i >= 16)        count += q[i-16];  // Top neighbor
        if (i < 240)        count += q[i+16];  // Bottom neighbor
        if (i >= 16 && i % 16 != 0)     count += q[i-17]; // Top-left neighbor
        if (i >= 16 && i % 16 != 15)    count += q[i-15]; // Top-right neighbor
        if (i < 240 && i % 16 != 0)     count += q[i+15]; // Bottom-left neighbor
        if (i < 240 && i % 16 != 15)    count += q[i+17]; // Bottom-right neighbor

        // Apply the game of life rules to update the next state
        if (q[i] == 1) begin
            if (count == 2 || count == 3) begin
                next_state[i] = 1;
            end else begin
                next_state[i] = 0;
            end
        end else begin
            if (count == 3) begin
                next_state[i] = 1;
            end else begin
                next_state[i] = 0;
            end
        end
    end
end

endmodule
