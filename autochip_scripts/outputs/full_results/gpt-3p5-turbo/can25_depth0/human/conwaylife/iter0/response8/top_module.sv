module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_temp; // Temporary variable to store the updated state

    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load initial state
        end else begin
            // Calculate the updated state
            for (int i = 0; i < 256; i = i + 16) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    int count = 0; // Number of neighbors
                    
                    // Check each neighbor
                    if (q[(i + ((j + 15) % 16))] == 1) count = count + 1; // Left
                    if (q[(i + ((j + 1) % 16))] == 1) count = count + 1; // Right
                    if (q[(i + 16 + j) % 256] == 1) count = count + 1; // Above
                    if (q[(i + 240 + j) % 256] == 1) count = count + 1; // Below
                    if (q[(i + 16 + ((j + 15) % 16))] == 1) count = count + 1; // Upper-left
                    if (q[(i + 16 + ((j + 1) % 16))] == 1) count = count + 1; // Upper-right
                    if (q[(i + 240 + ((j + 15) % 16))] == 1) count = count + 1; // Lower-left
                    if (q[(i + 240 + ((j + 1) % 16))] == 1) count = count + 1; // Lower-right
                    
                    // Update cell state based on neighbor count
                    if (count <= 1)
                        q_temp[i + j] <= 0;
                    else if (count == 2)
                        q_temp[i + j] <= q[i + j];
                    else if (count == 3)
                        q_temp[i + j] <= 1;
                    else
                        q_temp[i + j] <= 0;
                end
            end
            
            q <= q_temp; // Update q with the new state
        end
    end

endmodule
