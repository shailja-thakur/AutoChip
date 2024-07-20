module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    reg [255:0] q_next;
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 256; i=i+16) begin
                for (int j = 0; j < 16; j=j+1) begin
                    int count = 0;
                    int up_row, down_row, left_col, right_col;
                    
                    if (i == 0) begin
                        up_row = 240;
                        down_row = i+16;
                    end else if (i == 240) begin
                        up_row = i-16;
                        down_row = 0;
                    end else begin
                        up_row = i-16;
                        down_row = i+16;
                    end
                    
                    if (j == 0) begin
                        left_col = 15;
                        right_col = j+1;
                    end else if (j == 15) begin
                        left_col = j-1;
                        right_col = 0;
                    end else begin
                        left_col = j-1;
                        right_col = j+1;
                    end
                    
                    if (q[up_row+left_col]) begin
                        count = count + 1;
                    end
                    if (q[up_row+j]) begin
                        count = count + 1;
                    end
                    if (q[up_row+right_col]) begin
                        count = count + 1;
                    end
                    if (q[i+left_col]) begin
                        count = count + 1;
                    end
                    if (q[i+right_col]) begin
                        count = count + 1;
                    end
                    if (q[down_row+left_col]) begin
                        count = count + 1;
                    end
                    if (q[down_row+j]) begin
                        count = count + 1;
                    end
                    if (q[down_row+right_col]) begin
                        count = count + 1;
                    end
                    
                    if (count == 0 || count == 1) begin
                        q_next[i+j] <= 0;
                    end else if (count == 2) begin
                        q_next[i+j] <= q[i+j];
                    end else if (count == 3) begin
                        q_next[i+j] <= 1;
                    end else if (count >= 4) begin
                        q_next[i+j] <= 0;
                    end
                end
            end
            q <= q_next;
        end
    end
endmodule
