module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    // Compute the next state of each cell
    for (int i = 0; i < 16; i++) begin
        for (int j = 0; j < 16; j++) begin
            int index = i * 16 + j;
            int num_neighbors = 0;

            // Count the number of alive neighbors
            if (i > 0 && q[index - 16]) num_neighbors++;
            if (i < 15 && q[index + 16]) num_neighbors++;
            if (j > 0 && q[index - 1]) num_neighbors++;
            if (j < 15 && q[index + 1]) num_neighbors++;
            if (i > 0 && j > 0 && q[index - 17]) num_neighbors++;
            if (i > 0 && j < 15 && q[index - 15]) num_neighbors++;
            if (i < 15 && j > 0 && q[index + 15]) num_neighbors++;
            if (i < 15 && j < 15 && q[index + 17]) num_neighbors++;

            // Update the next state of the cell based on the number of neighbors
            if (q[index] && (num_neighbors == 2 || num_neighbors == 3)) begin
                next_q[index] = 1'b1;
            end
            else if (!q[index] && num_neighbors == 3) begin
                next_q[index] = 1'b1;
            end
            else begin
                next_q[index] = 1'b0;
            end
        end
    end
end

endmodule
