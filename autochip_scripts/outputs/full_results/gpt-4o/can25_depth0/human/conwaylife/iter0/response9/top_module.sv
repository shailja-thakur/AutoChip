module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;

    // Load initial state
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            reg [255:0] next_q;
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    integer idx = i*16 + j;
                    integer alive_neighbors = 0;
                    // Check all 8 neighbors
                    alive_neighbors = q[((i-1+16)%16)*16 + ((j-1+16)%16)] + q[((i-1+16)%16)*16 + j] + q[((i-1+16)%16)*16 + ((j+1)%16)] +
                                      q[i*16 + ((j-1+16)%16)]                             + q[i*16 + ((j+1)%16)] +
                                      q[((i+1)%16)*16 + ((j-1+16)%16)] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + ((j+1)%16)];
                    
                    // Apply the game rules
                    if (q[idx] == 1) begin
                        if (alive_neighbors < 2 || alive_neighbors > 3) begin
                            next_q[idx] = 0;
                        end
                        else begin
                            next_q[idx] = 1;
                        end
                    end
                    else begin
                        if (alive_neighbors == 3) begin
                            next_q[idx] = 1;
                        end
                        else begin
                            next_q[idx] = 0;
                        end
                    end
                end
            end
            q <= next_q;
        end
    end
endmodule
