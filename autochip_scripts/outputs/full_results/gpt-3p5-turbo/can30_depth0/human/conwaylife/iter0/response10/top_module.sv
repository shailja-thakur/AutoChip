module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
    
    reg [255:0] q_next; // temporary wire to store the next state of q
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    // Loop through each cell in the 16x16 grid
    genvar i, j;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                
                // Calculate the indices of the cell's neighbors
                // Wrap around the grid using modulo operator
                // Assuming (0,0) is the top-left cell
                // (i-1,j-1), (i-1,j), (i-1,j+1)
                // (i,j-1),   (i,j),   (i,j+1)
                // (i+1,j-1), (i+1,j), (i+1,j+1)
                wire n1, n2, n3, n4, n5, n6, n7, n8;
                if (i == 0) begin
                    n1 = q[15 + 16*j];
                    n2 = q[15 + 16*(j+1)];
                    n3 = q[15 + 16*((j-1+16)%16)];
                end else if (i == 15) begin
                    n1 = q[16*j];
                    n2 = q[16*((j+1)%16)];
                    n3 = q[16*((j-1+16)%16)];
                end else begin
                    n1 = q[(i-1) + 16*j];
                    n2 = q[(i-1) + 16*((j+1)%16)];
                    n3 = q[(i-1) + 16*((j-1+16)%16)];
                end
                
                if (j == 0) begin
                    n4 = q[i + 16*15];
                    n5 = q[(i+1)%16 + 16*15];
                    n6 = q[(i-1+16)%16 + 16*15];
                end else if (j == 15) begin
                    n4 = q[i];
                    n5 = q[(i+1)%16];
                    n6 = q[(i-1+16)%16];
                end else begin
                    n4 = q[i + 16*(j-1)];
                    n5 = q[(i+1)%16 + 16*(j-1)];
                    n6 = q[(i-1+16)%16 + 16*(j-1)];
                end
                
                n7 = q[(i+1)%16 + 16*j];
                n8 = q[(i+1)%16 + 16*((j+1)%16)];
                
                // Calculate the number of live neighbors
                wire count;
                count = n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8;
                
                // Update the cell's state based on the number of live neighbors
                always @* begin
                    if (count == 3) begin
                        q_next[i + 16*j] = 1;
                    end else if (count == 2) begin
                        q_next[i + 16*j] = q[i + 16*j];
                    end else begin
                        q_next[i + 16*j] = 0;
                    end
                end
            end
        end
    endgenerate
endmodule
