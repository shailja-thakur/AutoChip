module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    reg [255:0] q_next;
    reg [255:0] q_temp;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end
    
    always @* begin
        for (int i = 0; i < 256; i = i + 16) begin
            for (int j = 0; j < 16; j = j + 1) begin
                int row = (i + j) / 16;
                int col = (i + j) % 16;
                int prev_col = col - 1;
                int next_col = col + 1;
                int prev_row = row - 1;
                int next_row = row + 1;
                
                if (prev_row < 0) begin
                    prev_row = 15;
                end
                
                if (next_row > 15) begin
                    next_row = 0;
                end
                
                if (prev_col < 0) begin
                    prev_col = 15;
                end
                
                if (next_col > 15) begin
                    next_col = 0;
                end
                
                int current_cell = q[i + j];
                int num_neighbors = q[i + prev_col] + q[i + next_col] + q[i + 16 + col] + q[i - 16 + col] + 
                    q[i - 16 + prev_col] + q[i - 16 + next_col] + q[i + 16 + prev_col] + q[i + 16 + next_col];
                
                if (num_neighbors <= 1 || num_neighbors >= 4) begin
                    q_next[i + j] = 0;
                end else if (num_neighbors == 3) begin
                    q_next[i + j] = 1;
                end else begin
                    q_next[i + j] = current_cell;
                end
            end
        end
    end
endmodule
