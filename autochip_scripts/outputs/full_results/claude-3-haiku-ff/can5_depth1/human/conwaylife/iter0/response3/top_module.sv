module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_state;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_state;
    end
end

always @(*) begin
    next_state = q;
    for (int i = 0; i < 256; i++) begin
        int row = i / 16;
        int col = i % 16;
        int neighbors = 0;

        // Check neighbors
        if (row > 0)
            neighbors += q[(i - 16) % 256];
        if (row < 15)
            neighbors += q[(i + 16) % 256];
        if (col > 0)
            neighbors += q[i - 1];
        if (col < 15)
            neighbors += q[i + 1];
        if (row > 0 && col > 0)
            neighbors += q[(i - 17) % 256];
        if (row > 0 && col < 15)
            neighbors += q[(i - 15) % 256];
        if (row < 15 && col > 0)
            neighbors += q[(i + 15) % 256];
        if (row < 15 && col < 15)
            neighbors += q[(i + 17) % 256];

        // Update next state
        if (q[i] == 1'b1) begin
            if (neighbors < 2 || neighbors > 3)
                next_state[i] = 1'b0;
            else
                next_state[i] = 1'b1;
        end
        else begin
            if (neighbors == 3)
                next_state[i] = 1'b1;
            else
                next_state[i] = 1'b0;
        end
    end
end

endmodule
