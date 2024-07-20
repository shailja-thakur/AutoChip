module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    integer i, j;
    reg [15:0] current_state [15:0]; // 16x16 array for current state
    reg [15:0] next_state [15:0];    // 16x16 array for next state
    
    // Helper function to count the number of alive neighbours
    function integer count_neighbours;
        input integer x, y;
        integer x_wrap, y_wrap;
        integer sum;
    begin
        sum = 0;
        for (x_wrap = -1; x_wrap <= 1; x_wrap = x_wrap + 1) begin
            for (y_wrap = -1; y_wrap <= 1; y_wrap = y_wrap + 1) begin
                if (x_wrap != 0 || y_wrap != 0) begin
                    sum = sum + current_state[(x + x_wrap) & 4'hF][(y + y_wrap) & 4'hF];
                end
            end
        end
        count_neighbours = sum;
    end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
            // Load data into the current_state array
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    current_state[i][j] <= data[i*16 + j];
                end
            end
        end else begin
            // Compute the next state based on the current state.
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    case (count_neighbours(i, j))
                        3: next_state[i][j] <= 1;                      // 3 neighbours -> alive
                        2: next_state[i][j] <= current_state[i][j];   // 2 neighbours -> unchanged
                        default: next_state[i][j] <= 0;               // 0-1 or 4+ neighbours -> dead
                    endcase
                end
            end
            
            // Update q and current_state with next_state
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    q[i*16 + j] <= next_state[i][j];
                    current_state[i][j] <= next_state[i][j];
                end
            end
        end
    end
endmodule
