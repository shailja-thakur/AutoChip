module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    // Declare internal wires
    wire [255:0] next_q;

    // Registers for next state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    // Compute next state
    generate
        genvar i;
        genvar j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                assign next_q[i*16 + j] = compute_next_state(i, j);
            end
        end
    endgenerate

    // Function to compute next state for a cell
    function compute_next_state;
        input [3:0] num_neighbors;
        begin
            if (num_neighbors == 0 || num_neighbors == 1) begin
                compute_next_state = 0;
            end else if (num_neighbors == 2) begin
                compute_next_state = q[i*16 + j];
            end else if (num_neighbors == 3) begin
                compute_next_state = 1;
            end else begin
                compute_next_state = 0;
            end
        end
    endfunction

    // Count number of neighbors for each cell
    function [3:0] count_neighbors;
        input [7:0] i;
        input [7:0] j;
        reg [3:0] count;
        begin
            count = 0;
            if (q[i*16 + ((j+1) % 16)]) count = count + 1;
            if (q[i*16 + ((j-1) % 16)]) count = count + 1;
            if (q[((i+1) % 16)*16 + j]) count = count + 1;
            if (q[((i-1) % 16)*16 + j]) count = count + 1;
            if (q[((i+1) % 16)*16 + ((j+1) % 16)]) count = count + 1;
            if (q[((i+1) % 16)*16 + ((j-1) % 16)]) count = count + 1;
            if (q[((i-1) % 16)*16 + ((j+1) % 16)]) count = count + 1;
            if (q[((i-1) % 16)*16 + ((j-1) % 16)]) count = count + 1;
            count_neighbors = count;
        end
    endfunction

    // Calculate number of neighbors for each cell
    generate
        genvar i;
        genvar j;
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                assign count_neighbors[i][j] = count_neighbors(i, j);
            end
        end
    endgenerate

endmodule
