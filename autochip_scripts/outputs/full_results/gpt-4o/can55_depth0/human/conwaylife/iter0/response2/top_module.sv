module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

    // Internal registers
    reg [255:0] next_q;
    
    // Function to count 1's in 8 neighbors of toroid
    function integer count_neighbors(
        input [255:0] grid,
        input integer x,
        input integer y); 
        integer ix, iy, neighbors;
        begin
            neighbors = 0;
            // Check 3x3 grid surrounding cell (x,y)
            for (ix = -1; ix <= 1; ix = ix + 1) begin
                for (iy = -1; iy <= 1; iy = iy + 1) begin
                    if (!(ix == 0 && iy == 0)) begin
                        // Use mod arithmetic to wrap around
                        neighbors = neighbors + grid[((x+ix+16)%16) * 16 + ((y+iy+16)%16)];
                    end
                end
            end
            count_neighbors = neighbors;
        end
    endfunction
    
    // Compute next grid state
    integer x, y, count;
    always @* begin
        for (x = 0; x < 16; x = x + 1) begin
            for (y = 0; y < 16; y = y + 1) begin
                count = count_neighbors(q, x, y);
                if (count < 2 || count > 3) begin
                    next_q[x * 16 + y] = 0;
                end else if (count == 3) begin
                    next_q[x * 16 + y] = 1;
                end else begin
                    next_q[x * 16 + y] = q[x * 16 + y];
                end
            end
        end
    end
    
    // Sequential logic to update grid
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
