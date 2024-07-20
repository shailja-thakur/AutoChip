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
    end
    else begin
        q <= next_q;
    end
end

// Helper functions to calculate the number of neighbors
function integer get_neighbors(input [255:0] state, input integer x, input integer y);
    integer count;
    integer x_left, x_right, y_up, y_down;
    begin
        count = 0;
        x_left = (x == 0) ? 15 : x - 1;
        x_right = (x == 15) ? 0 : x + 1;
        y_up = (y == 0) ? 15 : y - 1;
        y_down = (y == 15) ? 0 : y + 1;
        
        // Check the 8 neighboring cells
        count += (state[x_left + y*16] & 1'b1);
        count += (state[x_right + y*16] & 1'b1);
        count += (state[x + y_up*16] & 1'b1);
        count += (state[x + y_down*16] & 1'b1);
        count += (state[x_left + y_up*16] & 1'b1);
        count += (state[x_left + y_down*16] & 1'b1);
        count += (state[x_right + y_up*16] & 1'b1);
        count += (state[x_right + y_down*16] & 1'b1);
        
        get_neighbors = count;
    end
endfunction

always @(*) begin
    for (integer i = 0; i < 16; i++) begin
        for (integer j = 0; j < 16; j++) begin
            integer neighbors = get_neighbors(q, i, j);
            if (q[i + j*16] == 1'b1) begin
                if (neighbors == 2 || neighbors == 3) begin
                    next_q[i + j*16] = 1'b1;
                end
                else begin
                    next_q[i + j*16] = 1'b0;
                end
            end
            else begin
                if (neighbors == 3) begin
                    next_q[i + j*16] = 1'b1;
                end
                else begin
                    next_q[i + j*16] = 1'b0;
                end
            end
        end
    end
end

endmodule
