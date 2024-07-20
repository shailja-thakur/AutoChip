module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [3:0] neighbor_count[255:0]; // to hold neighbour counts for each cell
    
    integer i, j, row, col;
    
    // Function to calculate the index in a toroidal fashion
    function integer toroid_index;
        input integer row, col;
        begin
            toroid_index = ((row + 16) % 16) * 16 + ((col + 16) % 16);
        end
    endfunction
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Reset the neighbor_count array
            for (i = 0; i < 256; i = i + 1) begin
                neighbor_count[i] <= 0;
            end
            
            // Count neighbors for each cell
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    // Sum the neighbors using the toroidal wrapping
                    integer index;
                    index = toroid_index(row, col);
                    
                    neighbor_count[index] <= 
                        q[toroid_index(row-1, col-1)] + q[toroid_index(row-1, col)] + q[toroid_index(row-1, col+1)] +
                        q[toroid_index(row, col-1)] + q[toroid_index(row, col+1)] +
                        q[toroid_index(row+1, col-1)] + q[toroid_index(row+1, col)] + q[toroid_index(row+1, col+1)];
                end
            end
            
            // Update the state based on neighbor count
            for (row = 0; row < 16; row = row + 1) begin
                for (col = 0; col < 16; col = col + 1) begin
                    integer index;
                    index = toroid_index(row, col);
                    case (neighbor_count[index])
                        4'd2: q[index] <= q[index]; // state does not change
                        4'd3: q[index] <= 1'b1; // cell becomes alive
                        default: q[index] <= 1'b0; // cell becomes dead
                    endcase
                end
            end
        end
    end
endmodule
