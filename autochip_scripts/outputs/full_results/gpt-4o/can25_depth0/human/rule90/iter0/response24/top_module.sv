module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Set the initial state of the system
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Generate the next state according to Rule 90
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                // Handle the boundaries with zero padding
                if (i == 0) begin
                    next_q[i] = q[i+1]; // Left boundary [511:0][0]
                end
                else if (i == 511) begin
                    next_q[i] = q[i-1]; // Right boundary [511][0:0]
                end
                else begin
                    next_q[i] = q[i-1] ^ q[i+1]; // Rule 90 for all other cells
                end
            end
            q <= next_q;
        end
    end
endmodule
