module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end

    integer i, j;
    wire [3:0] neighbors;
    
    always @* begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                neighbors = 
                    q[((i+15)%16)*16 + ((j+15)%16)] + // Top Left
                    q[((i+15)%16)*16 + j] + // Top
                    q[((i+15)%16)*16 + ((j+1)%16)] + // Top Right
                    q[i*16 + ((j+15)%16)] + // Left
                    q[i*16 + ((j+1)%16)] + // Right
                    q[((i+1)%16)*16 + ((j+15)%16)] + // Bottom Left
                    q[((i+1)%16)*16 + j]  + // Bottom
                    q[((i+1)%16)*16 + ((j+1)%16)]; // Bottom Right
                
                case (neighbors)
                    4'h2: next_q[i*16 + j] = q[i*16 + j]; // Cell state does not change
                    4'h3: next_q[i*16 + j] = 1; // Cell becomes alive
                    default: next_q[i*16 + j] = 0; // Cell dies
                endcase
            end
        end
    end
endmodule
