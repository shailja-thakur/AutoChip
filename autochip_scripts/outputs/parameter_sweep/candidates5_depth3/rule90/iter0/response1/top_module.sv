module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal signal to hold the next state of cells
    reg [511:0] next_q;

    // Assign the next state of cells based on the current state
    always @(posedge clk) begin
        if (load)
            next_q <= data;
        else
            next_q[0] <= q[1] ^ q[0];

        // Iterate over each cell and calculate the next state
        for (int i = 1; i < 511; i = i + 1) begin
            next_q[i] <= q[i+1] ^ q[i-1];
        end

        next_q[511] <= q[510] ^ q[511];
    end

    // Assign the output to the current state of cells
    always @(posedge clk) begin
        q <= next_q;
    end

endmodule
