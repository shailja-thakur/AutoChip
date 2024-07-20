module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary register to hold the next state values
            reg [511:0] next_q;
            integer i;

            // Iterate over each cell to compute the next state
            for (i = 0; i < 512; i = i + 1) begin
                // Handle the boundaries with zero padding
                if (i == 0) begin
                    next_q[i] = q[i+1];
                end else if (i == 511) begin
                    next_q[i] = q[i-1];
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1];
                end
            end

            // Update the state
            q <= next_q;
        end
    end

endmodule
