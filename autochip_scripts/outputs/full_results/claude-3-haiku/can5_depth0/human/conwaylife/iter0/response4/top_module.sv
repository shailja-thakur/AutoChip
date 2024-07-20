module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Function to get the number of alive neighbors for a cell at index i
function integer get_alive_neighbors(input integer i);
    integer x, y, count;
    count = 0;
    x = i % 16;
    y = i / 16;
    
    // Check the 8 neighboring cells
    if (x > 0 && (q[i-1] == 1)) count++;
    if (x < 15 && (q[i+1] == 1)) count++;
    if (y > 0 && (q[(y-1)*16 + x] == 1)) count++;
    if (y < 15 && (q[(y+1)*16 + x] == 1)) count++;
    if (x > 0 && y > 0 && (q[(y-1)*16 + x-1] == 1)) count++;
    if (x < 15 && y > 0 && (q[(y-1)*16 + x+1] == 1)) count++;
    if (x > 0 && y < 15 && (q[(y+1)*16 + x-1] == 1)) count++;
    if (x < 15 && y < 15 && (q[(y+1)*16 + x+1] == 1)) count++;
    
    return count;
endfunction

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (integer i = 0; i < 256; i++) begin
            integer alive_neighbors = get_alive_neighbors(i);
            if (q[i] == 1) begin
                if (alive_neighbors < 2 || alive_neighbors > 3) begin
                    q[i] <= 0;
                end
                else begin
                    q[i] <= 1;
                end
            end
            else begin
                if (alive_neighbors == 3) begin
                    q[i] <= 1;
                end
                else begin
                    q[i] <= 0;
                end
            end
        end
    end
end

endmodule
