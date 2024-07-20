module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            reg [255:0] next_q;
            integer x, y;
            integer nx, ny;
            integer i, j;
            integer neighbors;
            
            for (x = 0; x < 16; x = x + 1) begin
                for (y = 0; y < 16; y = y + 1) begin
                    neighbors = 0;
                    
                    for (i = -1; i <= 1; i = i + 1) begin
                        for (j = -1; j <= 1; j = j + 1) begin
                            if (!(i == 0 && j == 0)) begin
                                nx = (x + i + 16) % 16;
                                ny = (y + j + 16) % 16;
                                neighbors = neighbors + q[16*nx + ny];
                            end
                        end
                    end
                    
                    if (neighbors <= 1) begin
                        next_q[16*x + y] = 0;
                    end
                    else if (neighbors == 2) begin
                        next_q[16*x + y] = q[16*x + y];
                    end
                    else if (neighbors == 3) begin
                        next_q[16*x + y] = 1;
                    end
                    else begin
                        next_q[16*x + y] = 0;
                    end
                end
            end
            
            q <= next_q;
        end
    end
endmodule
