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
        for (genvar i = 0; i < 256; i=i+16) begin
            for (genvar j = 0; j < 16; j = j+1) begin
                reg neighbors;
                
                // Count the number of alive neighbors
                if (j > 0) begin
                    neighbors = q[i+j-1];
                end else begin
                    neighbors = q[i+15];
                end
                
                neighbors = neighbors + q[i+(j+1)%16];
                neighbors = neighbors + q[i+((j+1)%16)-1];
                
                if (i > 0) begin
                    neighbors = neighbors + q[i+j-16];
                    neighbors = neighbors + q[i+(j+1)%16-16];
                    neighbors = neighbors + q[i+((j+1)%16)-16];
                end else begin
                    neighbors = neighbors + q[i+j+240];
                    neighbors = neighbors + q[i+(j+1)%16+240];
                    neighbors = neighbors + q[i+((j+1)%16)+240];
                end
                
                if (i < 240) begin
                    neighbors = neighbors + q[i+j+16];
                    neighbors = neighbors + q[i+(j+1)%16+16];
                    neighbors = neighbors + q[i+((j+1)%16)+16];
                end else begin
                    neighbors = neighbors + q[i+j-240];
                    neighbors = neighbors + q[i+(j+1)%16-240];
                    neighbors = neighbors + q[i+((j+1)%16)-240];
                end
                                
                // Update cell state based on number of neighbors
                if (neighbors == 0 || neighbors == 1) begin
                    next_q[i+j] = 0;
                end else if (neighbors == 2) begin
                    next_q[i+j] = q[i+j];
                end else if (neighbors == 3) begin
                    next_q[i+j] = 1;
                end else begin
                    next_q[i+j] = 0;
                end
            end
        end
        q <= next_q;
    end
end

endmodule
