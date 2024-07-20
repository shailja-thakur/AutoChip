module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
    reg [255:0] next_q;
    reg [7:0] num_neighbors;
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate the next state of each cell
            for (integer i = 0; i < 16; i = i + 1) begin
                for (integer j = 0; j < 16; j = j + 1) begin
                    num_neighbors = q[((i-1+16)%16)*16 + (j-1+16)%16] + q[((i-1+16)%16)*16 + j] + q[((i-1+16)%16)*16 + (j+1)%16] + q[(i*16 + (j-1+16)%16)] + q[(i*16 + (j+1)%16)] + q[((i+1)%16)*16 + (j-1+16)%16] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + (j+1)%16];
                    
                    if (num_neighbors <= 1) begin
                        next_q[i*16 + j] = 0;
                    end else if (num_neighbors == 2) begin
                        next_q[i*16 + j] = q[i*16 + j];
                    end else if (num_neighbors == 3) begin
                        next_q[i*16 + j] = 1;
                    end else if (num_neighbors >= 4) begin
                        next_q[i*16 + j] = 0;
                    end
                end
            end
            
            q <= next_q;
        end
    end
endmodule
