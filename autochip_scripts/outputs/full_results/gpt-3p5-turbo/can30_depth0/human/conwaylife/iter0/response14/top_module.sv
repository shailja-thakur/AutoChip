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
    end else begin
        q <= next_q;
    end
end

// Generate the next game state
integer i, j;
reg [255:0] neighborCount;

always @* begin
    for (i = 0; i < 256; i = i + 1) begin
        // Calculate the row and column index for the current cell
        reg [3:0] row = i / 16;
        reg [3:0] col = i % 16;
        
        // Count the number of live neighbors for the current cell
        neighborCount[i] = 0;
        
        if (q[((row - 1) & 15) * 16 + ((col - 1) & 15)]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[((row - 1) & 15) * 16 + ((col + 1) & 15)]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[((row - 1) & 15) * 16 + col]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[((row + 1) & 15) * 16 + ((col - 1) & 15)]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[((row + 1) & 15) * 16 + ((col + 1) & 15)]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[((row + 1) & 15) * 16 + col]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[(row * 16 + ((col - 1) & 15))]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        if (q[(row * 16 + ((col + 1) & 15))]) begin
            neighborCount[i] = neighborCount[i] + 1;
        end
        
        // Calculate the next state based on the number of neighbors
        if (neighborCount[i] < 2) begin
            next_q[i] = 0;
        end else if (neighborCount[i] == 2) begin
            next_q[i] = q[i];
        end else if (neighborCount[i] == 3) begin
            next_q[i] = 1;
        end else begin
            next_q[i] = 0;
        end
    end
end

endmodule
