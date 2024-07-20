module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Temporary register to store the next state
    reg [511:0] next_q;

    integer i;
    
    always @(posedge clk) begin
        if (load) begin
            // Load the data into q if load is high
            q <= data;
        end else begin
            // Apply Rule 90 to compute the next state
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = q[i + 1]; // q[-1] = 0
                end else if (i == 511) begin
                    next_q[i] = q[i - 1]; // q[512] = 0
                end else begin
                    next_q[i] = q[i - 1] ^ q[i + 1];
                end
            end
            // Update the q with the next state
            q <= next_q;
        end
    end

endmodule
