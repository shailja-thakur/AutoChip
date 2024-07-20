module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load the initial state
        end else begin
            reg [511:0] next_q;
            // Iterate through each cell to compute the next state
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    next_q[i] = q[i+1]; // Boundary condition at the leftmost cell
                end else if (i == 511) begin
                    next_q[i] = q[i-1]; // Boundary condition at the rightmost cell
                end else begin
                    next_q[i] = q[i-1] ^ q[i+1]; // Rule 90 logic
                end
            end
            q <= next_q; // Update the state
        end
    end
endmodule
