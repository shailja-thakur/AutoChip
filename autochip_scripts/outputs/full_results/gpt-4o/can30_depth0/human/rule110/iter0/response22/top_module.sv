module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Temporary variable to hold next state
            reg [511:0] next;
            integer i;
            
            // Update the state according to Rule 110
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Edge case for the left boundary
                    next[i] = (q[511] == 0 && q[0] == 1 && q[1] == 1) ||
                              (q[511] == 1 && q[0] == 1 && q[1] == 0) ||
                              (q[511] == 1 && q[0] == 0 && q[1] == 1);
                end else if (i == 511) begin
                    // Edge case for the right boundary
                    next[i] = (q[510] == 0 && q[511] == 1 && q[0] == 0) ||
                              (q[510] == 0 && q[511] == 1 && q[0] == 1) ||
                              (q[510] == 1 && q[511] == 0 && q[0] == 1);
                end else begin
                    // Handling for all other cells
                    next[i] = (q[i-1] == 0 && q[i] == 1 && q[i+1] == 1) ||
                              (q[i-1] == 0 && q[i] == 1 && q[i+1] == 0) ||
                              (q[i-1] == 1 && q[i] == 0 && q[i+1] == 1) ||
                              (q[i-1] == 1 && q[i] == 1 && q[i+1] == 0);
                end
            end
            
            // Set the next state to q
            q <= next;
        end
    end

endmodule
