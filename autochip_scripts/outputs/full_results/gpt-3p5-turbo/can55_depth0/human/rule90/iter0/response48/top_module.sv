module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal signals
    reg [511:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Boundary conditions
            q_next[0] = q[511] ^ q[1];
            q_next[511] = q[510] ^ q[0];

            // Update the state of each cell
            for (int i = 1; i < 511; i = i + 1) begin
                q_next[i] = q[i-1] ^ q[i+1];
            end

            q <= q_next;
        end
    end
endmodule
