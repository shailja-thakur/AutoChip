module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
 
    reg [255:0] temp_q; // Temporary variable to compute next state
    
    always @ (posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            // Compute next state based on current state (q)
            // and update temp_q
            for (int i = 0; i < 256; i = i + 16) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    int neighbors = 0;
                    int col = (i + j) % 16;
                    int row = (i + j) / 16;
                    
                    // Count number of neighbors for each cell
                    if (q[((row+15)%16)*16 + ((col+15)%16)]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[((row+15)%16)*16 + ((col+1)%16)]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[((row+15)%16)*16 + col]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[(row*16 + ((col+15)%16))]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[(row*16 + ((col+1)%16))]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[((row+1)%16)*16 + ((col+15)%16)]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[((row+1)%16)*16 + ((col+1)%16)]) begin
                        neighbors = neighbors + 1;
                    end
                    if (q[((row+1)%16)*16 + col]) begin
                        neighbors = neighbors + 1;
                    end
                    
                    // Determine next state based on number of neighbors
                    if (neighbors == 3) begin
                        temp_q[i + j] = 1;
                    end
                    else if (neighbors == 2) begin
                        temp_q[i + j] = q[i + j];
                    end
                    else begin
                        temp_q[i + j] = 0;
                    end
                end
            end
            
            q <= temp_q; // Update q with the next state
        end
    end
    
endmodule
