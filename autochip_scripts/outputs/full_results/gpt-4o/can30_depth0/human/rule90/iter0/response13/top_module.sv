module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Intermediate register to store next state
    reg [511:0] next_state;

    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load the input data into q
        end else begin
            // Calculate the next state according to Rule 90
            next_state[0] = q[1]; // q[-1] is considered 0
            next_state[511] = q[510]; // q[512] is considered 0
            for (i = 1; i < 511; i = i + 1) begin
                next_state[i] = q[i-1] ^ q[i+1];
            end
            q <= next_state; // Update q with the next state
        end
    end

endmodule
