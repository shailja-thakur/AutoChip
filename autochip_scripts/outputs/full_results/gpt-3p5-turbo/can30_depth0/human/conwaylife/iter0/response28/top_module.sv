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
            next_q = q;
            
            for (int i = 0; i < 16; i = i + 1) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    int count = 0;
                    
                    // Count neighbors
                    if (q[i*16 + (j+1)%16] == 1) count = count + 1;
                    if (q[(i+1)%16*16 + (j+1)%16] == 1) count = count + 1;
                    if (q[(i+1)%16*16 + j] == 1) count = count + 1;
                    if (q[(i+1)%16*16 + (j+15)%16] == 1) count = count + 1;
                    if (q[i*16 + (j+15)%16] == 1) count = count + 1;
                    if (q[(i+15)%16*16 + (j+15)%16] == 1) count = count + 1;
                    if (q[(i+15)%16*16 + j] == 1) count = count + 1;
                    if (q[(i+15)%16*16 + (j+1)%16] == 1) count = count + 1;
                    
                    // Determine next state based on neighbor count
                    if (count == 2) begin
                        next_q[i*16 + j] <= q[i*16 + j];
                    end else if (count == 3) begin
                        next_q[i*16 + j] <= 1;
                    end else begin
                        next_q[i*16 + j] <= 0;
                    end
                end
            end
            
            q <= next_q;
        end
    end

endmodule
