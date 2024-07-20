module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            // Load the initial state when load signal is high
            q <= data;
        end else begin
            // Temporary variable to store the next state of q
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = 0 ^ q[i+1];  // q[-1] is 0 (left boundary)
                end else if (i == 511) begin
                    next_q[i] = q[i-1] ^ 0;  // q[512] is 0 (right boundary)
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];  // Rule 90 operation
                end
            end
            // Update q with the next state
            q <= next_q;
        end
    end

endmodule
