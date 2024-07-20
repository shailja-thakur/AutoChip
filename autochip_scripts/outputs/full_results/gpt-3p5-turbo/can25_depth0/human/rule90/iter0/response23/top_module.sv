module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    // Internal wires
    wire [511:0] next_state;

    // Register to keep track of the previous state
    reg [511:0] prev_state;

    // Output register
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_state;
    end

    // Logic to calculate the next state
    always @(*) begin
        // Boundary conditions
        if (q[0])
            next_state[0] = (q[1] ^ 0);
        else
            next_state[0] = (q[1] ^ 1);

        if (q[511])
            next_state[511] = (0 ^ q[510]);
        else
            next_state[511] = (1 ^ q[510]);

        // Center cells
        for (int i = 1; i < 511; i = i + 1) begin
            if (q[i])
                next_state[i] = (q[i-1] ^ q[i+1]);
            else
                next_state[i] = (q[i-1] ^ ~q[i+1]);
        end
    end

    // Assign the next state to the output register
    always @(posedge clk) begin
        prev_state <= q;
        q <= next_state;
    end

    // Initial state
    initial begin
        q <= 512'b0;
        prev_state <= 512'b0;
    end

endmodule
