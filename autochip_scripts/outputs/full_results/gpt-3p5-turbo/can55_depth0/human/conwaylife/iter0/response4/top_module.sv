module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (integer i = 0; i < 256; i = i + 1) begin
                integer count = 0;
                if (i >= 16) begin
                    count = count + q[i-16];
                    if (i % 16 != 0) begin
                        count = count + q[i-17];
                    end
                    if (i % 16 != 15) begin
                        count = count + q[i-15];
                    end
                end
                if (i < 240) begin
                    count = count + q[i+16];
                    if (i % 16 != 0) begin
                        count = count + q[i+15];
                    end
                    if (i % 16 != 15) begin
                        count = count + q[i+17];
                    end
                end
                if (i % 16 != 0) begin
                    count = count + q[i-1];
                end
                if (i % 16 != 15) begin
                    count = count + q[i+1];
                end
                if (count == 2) begin
                    q[i] <= q[i];
                end else if (count == 3) begin
                    q[i] <= 1;
                end else begin
                    q[i] <= 0;
                end
            end
        end
    end
endmodule
