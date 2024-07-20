module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] next_q;
    reg [255:0] count;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            next_q = q;

            for (integer i = 0; i < 256; i = i + 1) begin
                count[i] = 0;
            end

            for (integer i = 0; i < 256; i = i + 1) begin
                if (i % 16 != 0) begin
                    count[i] = count[i] + q[i-1];
                end
                if (i % 16 != 15) begin
                    count[i] = count[i] + q[i+1];
                end
                if (i >= 16) begin
                    count[i] = count[i] + q[i-16];
                end
                if (i < 240) begin
                    count[i] = count[i] + q[i+16];
                end
                if (i % 16 != 0 && i >= 16) begin
                    count[i] = count[i] + q[i-17];
                end
                if (i % 16 != 0 && i < 240) begin
                    count[i] = count[i] + q[i+15];
                end
                if (i % 16 != 15 && i >= 16) begin
                    count[i] = count[i] + q[i-15];
                end
                if (i % 16 != 15 && i < 240) begin
                    count[i] = count[i] + q[i+17];
                end
            end

            for (integer i = 0; i < 256; i = i + 1) begin
                if (count[i] == 3) begin
                    next_q[i] = 1;
                end else if (count[i] == 2 && q[i] == 1) begin
                    next_q[i] = 1;
                end else begin
                    next_q[i] = 0;
                end
            end

            q <= next_q;
        end
    end

endmodule
