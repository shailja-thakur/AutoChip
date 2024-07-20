module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    reg [511:0] next_q;

    // Define the next state logic based on Rule 110
    always @* begin
        next_q = 512'b0; // Initialize the next state array to zero

        // Iterate over each cell
        integer i;
        for (i = 0; i < 512; i = i + 1) begin
            // Define the neighbors for current cell
            wire left = (i == 0) ? 1'b0 : q[i - 1];
            wire center = q[i];
            wire right = (i == 511) ? 1'b0 : q[i + 1];

            // Apply Rule 110 to determine the next state of each cell
            next_q[i] = (left & center & ~right) | (left & ~center & right) |
                        (~left & center & right) | (~left & center & ~right);
        end
    end

    // Sequential logic for synchronous load and state update
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load new state
        end else begin
            q <= next_q; // Update to next state as per Rule 110
        end
    end

endmodule
