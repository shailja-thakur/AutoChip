module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q
);

reg [3:0] i, j;
reg [255:0] next_q;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Update the grid state
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                integer count;
                count = 0;

                // Count the alive neighbors
                count = q[(i-1+16)%16*16 + (j-1+16)%16] +
                        q[(i-1+16)%16*16 + j] +
                        q[(i-1+16)%16*16 + (j+1)%16] +
                        q[i*16 + (j-1+16)%16] +
                        q[i*16 + (j+1)%16] +
                        q[(i+1)%16*16 + (j-1+16)%16] +
                        q[(i+1)%16*16 + j] +
                        q[(i+1)%16*16 + (j+1)%16];

                // Determine the next state of the cell
                case (count)
                    2: next_q[i*16 + j] = q[i*16 + j];
                    3: next_q[i*16 + j] = 1;
                    default: next_q[i*16 + j] = 0;
                endcase
            end
        end
        q <= next_q;
    end
end

endmodule
