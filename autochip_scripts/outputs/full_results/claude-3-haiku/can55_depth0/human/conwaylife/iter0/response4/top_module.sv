module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(*) begin
    // Compute the next state based on the current state and the rules of the game
    for (int i = 0; i < 256; i++) begin
        int neighbors = 0;
        // Compute the number of alive neighbors for the current cell
        if (i > 0)        neighbors += q[i-1];
        if (i < 255)      neighbors += q[i+1];
        if (i >= 16)      neighbors += q[i-16];
        if (i < 240)      neighbors += q[i+16];
        if (i > 0 && i >= 16)   neighbors += q[i-17];
        if (i > 0 && i < 240)   neighbors += q[i+15];
        if (i < 255 && i >= 16) neighbors += q[i-15];
        if (i < 255 && i < 240) neighbors += q[i+17];

        // Apply the game rules to determine the next state of the current cell
        if (q[i] == 1) begin
            if (neighbors < 2 || neighbors > 3)
                next_state[i] = 0;
            else
                next_state[i] = 1;
        end else begin
            if (neighbors == 3)
                next_state[i] = 1;
            else
                next_state[i] = 0;
        end
    end
end

always @(posedge clk) begin
    if (load)
        q <= data;
    else
        q <= next_state;
end

endmodule
