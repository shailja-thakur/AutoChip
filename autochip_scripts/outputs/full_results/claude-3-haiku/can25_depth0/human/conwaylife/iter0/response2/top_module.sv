module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

wire [15:0] row[15:0];
wire [15:0] next_row[15:0];

// Assign input data to 16-bit rows
genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin
        assign row[i] = data[16*i +: 16];
    end
endgenerate

// Implement Game of Life logic
genvar j, k;
generate
    for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 16; k = k + 1) begin
            // Get the number of alive neighbors
            wire [3:0] alive_neighbors = 
                row[(j-1+16)%16][k] +
                row[(j+1)%16][k] +
                row[j][(k-1+16)%16] +
                row[j][(k+1)%16] +
                row[(j-1+16)%16][(k-1+16)%16] +
                row[(j-1+16)%16][(k+1)%16] +
                row[(j+1)%16][(k-1+16)%16] +
                row[(j+1)%16][(k+1)%16];

            // Apply Game of Life rules
            assign next_row[k][j] = (alive_neighbors == 3) || (alive_neighbors == 2 && row[j][k]);
        end
    end
endgenerate

// Update the game state on every clock cycle
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end else begin
        // Assign the updated rows to the output
        genvar l;
        generate
            for (l = 0; l < 16; l = l + 1) begin
                q[16*l +: 16] <= next_row[l];
            end
        endgenerate
    end
end

endmodule
