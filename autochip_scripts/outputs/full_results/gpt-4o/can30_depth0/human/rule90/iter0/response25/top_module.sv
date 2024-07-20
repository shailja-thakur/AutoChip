module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary array for the next state
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = 0 ^ q[i+1];     // Boundary condition for the first cell (left boundary is 0)
                else if (i == 511)
                    next_q[i] = q[i-1] ^ 0;    // Boundary condition for the last cell (right boundary is 0)
                else
                    next_q[i] = q[i-1] ^ q[i+1];  // General case
            end
            q <= next_q;
        end
    end
endmodule
