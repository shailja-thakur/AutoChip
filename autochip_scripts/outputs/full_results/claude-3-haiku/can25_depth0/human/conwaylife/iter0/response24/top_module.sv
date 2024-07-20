module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Helper functions
function int alive(input [255:0] grid, input [7:0] idx);
    int count = 0;
    // Wrap around grid indices
    count += grid[(idx + 255 - 16) % 256];   // North
    count += grid[(idx + 1) % 256];         // East
    count += grid[(idx + 16) % 256];        // South
    count += grid[(idx + 255 - 1) % 256];    // West
    count += grid[(idx + 255 - 17) % 256];   // Northwest
    count += grid[(idx + 1 + 16) % 256];     // Northeast
    count += grid[(idx + 16 + 1) % 256];     // Southeast
    count += grid[(idx + 255 - 16 - 1) % 256]; // Southwest
    return count;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        for (int i = 0; i < 256; i++) begin
            if (q[i]) begin
                // Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
                // Any live cell with two or three live neighbours lives on to the next generation.
                // Any live cell with more than three live neighbours dies, as if by overpopulation.
                if (alive(q, i) < 2 || alive(q, i) > 3) begin
                    q[i] <= 0;
                end else begin
                    q[i] <= 1;
                end
            end else begin
                // Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
                if (alive(q, i) == 3) begin
                    q[i] <= 1;
                end else begin
                    q[i] <= 0;
                end
            end
        end
    end
end

endmodule
