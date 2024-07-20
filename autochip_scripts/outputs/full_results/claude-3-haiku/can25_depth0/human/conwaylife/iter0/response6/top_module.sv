module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(*) begin
    // Calculate the number of neighbors for each cell
    reg [3:0] neighbors [0:255];
    integer i, j;
    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            // Calculate the number of neighbors for cell (i, j)
            neighbors[i * 16 + j] = 0;
            if (i > 0) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i - 1) * 16 + j];
            end
            if (i < 15) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i + 1) * 16 + j];
            end
            if (j > 0) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[i * 16 + j - 1];
            end
            if (j < 15) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[i * 16 + j + 1];
            end
            if (i > 0 && j > 0) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i - 1) * 16 + j - 1];
            end
            if (i > 0 && j < 15) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i - 1) * 16 + j + 1];
            end
            if (i < 15 && j > 0) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i + 1) * 16 + j - 1];
            end
            if (i < 15 && j < 15) begin
                neighbors[i * 16 + j] = neighbors[i * 16 + j] + q[(i + 1) * 16 + j + 1];
            end
        end
    end

    // Update the next state of each cell based on the number of neighbors
    for (i = 0; i < 256; i = i + 1) begin
        if (q[i] == 1'b1) begin
            if (neighbors[i] < 2 || neighbors[i] > 3) begin
                next_q[i] = 1'b0;
            end else begin
                next_q[i] = 1'b1;
            end
        end else begin
            if (neighbors[i] == 3) begin
                next_q[i] = 1'b1;
            end else begin
                next_q[i] = 1'b0;
            end
        end
    end
end

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        q <= next_q;
    end
end

endmodule
