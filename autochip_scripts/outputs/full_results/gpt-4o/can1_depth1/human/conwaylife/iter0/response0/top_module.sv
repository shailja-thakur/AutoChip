module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [3:0] neighbors;
            reg [255:0] next_state;

            for (int i = 0; i < 16; i = i + 1) begin
                for (int j = 0; j < 16; j = j + 1) begin
                    neighbors = 0;

                    // Check all 8 neighbors using toroidal addressing
                    neighbors = q[((i + 15) % 16) * 16 + ((j + 15) % 16)] + q[((i + 15) % 16) * 16 + j] + q[((i + 15) % 16) * 16 + ((j + 1) % 16)] +
                                q[i * 16 + ((j + 15) % 16)] + q[i * 16 + ((j + 1) % 16)] +
                                q[((i + 1) % 16) * 16 + ((j + 15) % 16)] + q[((i + 1) % 16) * 16 + j] + q[((i + 1) % 16) * 16 + ((j + 1) % 16)];
                    
                    if (neighbors == 2) begin
                        next_state[i * 16 + j] = q[i * 16 + j];
                    end else if (neighbors == 3) begin
                        next_state[i * 16 + j] = 1;
                    end else begin
                        next_state[i * 16 + j] = 0;
                    end
                end
            end

            q <= next_state;
        end
    end
endmodule
