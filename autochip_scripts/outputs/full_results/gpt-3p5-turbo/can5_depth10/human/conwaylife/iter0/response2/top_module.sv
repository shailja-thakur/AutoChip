module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_next;
    reg [255:0] q_neighbors;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate next state for each cell
            for (integer i = 0; i < 256; i = i + 1) begin
                // Get the neighbors of the current cell
                q_neighbors[0] = q[(i+15)%256];
                q_neighbors[7:1] = q[(i+15)%256] | q[(i+1)%256];
                q_neighbors[8] = q[(i+16)%256];
                q_neighbors[15:9] = q[(i+16)%256] | q[(i+32)%256];
                q_neighbors[16] = q[(i+32)%256];
                q_neighbors[23:17] = q[(i+32)%256] | q[(i+33)%256];
                q_neighbors[24] = q[(i+33)%256];
                q_neighbors[31:25] = q[(i+33)%256] | q[(i+17)%256];

                // Determine next state based on neighbors count
                if (q[i] == 1) begin
                    case (count(q_neighbors))
                        0: q_next[i] = 0;
                        1: q_next[i] = 0;
                        2: q_next[i] = 1;
                        3: q_next[i] = 1;
                        default: q_next[i] = 0;
                    endcase
                end else begin
                    case (count(q_neighbors))
                        3: q_next[i] = 1;
                        default: q_next[i] = 0;
                    endcase
                end
            end

            // Update q with next state
            q <= q_next;
        end
    end

    // Helper function to count the number of 1's in a vector
    function integer count(input [255:0] vec);
        integer count = 0;
        for (integer i = 0; i < 256; i = i + 1) begin
            if (vec[i] == 1) begin
                count = count + 1;
            end
        end
        return count;
    endfunction

endmodule
