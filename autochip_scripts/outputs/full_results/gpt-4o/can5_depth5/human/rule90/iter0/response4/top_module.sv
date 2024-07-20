module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q; // To hold the next state of the system

    integer i; // Loop variable

    always @(*) begin
        // Compute the next state of the system using Rule 90
        next_q[0] = q[1]; // Special case for the first cell
        for (i = 1; i < 511; i = i + 1) begin
            next_q[i] = q[i-1] ^ q[i+1];
        end
        next_q[511] = q[510]; // Special case for the last cell
    end

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load the initial state
        end else begin
            q <= next_q; // Advance to the next state
        end
    end

endmodule
