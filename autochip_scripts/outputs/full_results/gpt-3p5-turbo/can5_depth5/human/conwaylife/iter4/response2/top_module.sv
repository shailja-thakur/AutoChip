module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next_q;
    reg [255:0] next_row [0:15];
    reg [255:0] count;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            for (int i = 0; i < 16; i = i + 1) begin
                next_row[i] = q[16*i +: 16];

                for (int j = 0; j < 16; j = j + 1) begin
                    count = 0;

                    if (q[16*i + j] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+15)%16) + ((j+15)%16)] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+15)%16) + j] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+15)%16) + ((j+1)%16)] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*i + ((j+1)%16)] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+1)%16) + ((j+15)%16)] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+1)%16) + j] == 1) begin
                        count = count + 1;
                    end
                    if (q[16*((i+1)%16) + ((j+1)%16)] == 1) begin
                        count = count + 1;
                    end

                    if (count == 2) begin
                        next_row[i][j] = q[16*i + j];
                    end else if (count == 3) begin
                        next_row[i][j] = 1;
                    end else begin
                        next_row[i][j] = 0;
                    end
                end
            end
            
            for (int i = 0; i < 16; i = i + 1) begin
                next_q[16*i +: 16] = next_row[i];
            end
            
            q <= next_q;
        end
    end
    
endmodule
