module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;

    // Sequential block for updating state
    always @(posedge clk) begin
        if (load) // Load initial state
            q <= data;
        else begin
            q <= q_next; // Update state
        end
    end

    // Combinational block for updating next state
    always @(*) begin
        // Iterate over all cells
        for (int i = 0; i < 16; i=i+1) begin
            for (int j = 0; j < 16; j=j+1) begin
                // Calculate cell index in q based on row and column index
                int cell_index = i*16 + j;

                // Count the number of neighbors for the current cell
                int num_neighbors = 
                    q[(i-1)*16 + (j-1)] + q[(i-1)*16 + j] + q[(i-1)*16 + (j+1)] +
                    q[i*16 + (j-1)] + q[i*16 + (j+1)] +
                    q[(i+1)*16 + (j-1)] + q[(i+1)*16 + j] + q[(i+1)*16 + (j+1)];

                // Update the state of the cell based on the number of neighbors
                if (num_neighbors == 3)
                    q_next[cell_index] = 1;
                else if (num_neighbors == 2)
                    q_next[cell_index] = q[cell_index];
                else
                    q_next[cell_index] = 0;
            end
        end
    end

endmodule
