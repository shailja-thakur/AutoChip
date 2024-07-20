module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

// Define the 16x16 toroid
reg [15:0] row_top, row_bottom, col_left, col_right;

// Get the values of the neighboring cells
always @(*) begin
    row_top = {q[239:224], q[15:0]};
    row_bottom = {q[255:240], q[31:16]};
    col_left = {q[15:0], q[255:240]};
    col_right = {q[31:16], q[239:224]};
end

// Logic to update the game state
always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int i = 0; i < 256; i++) begin
            int neighbors = (q[i] & row_top[i%16]) + (q[i] & row_bottom[i%16]) + 
                            (q[i] & col_left[i/16]) + (q[i] & col_right[i/16]);
            q[i] <= (~q[i] & (neighbors == 3)) | (q[i] & (neighbors == 2));
        end
    end
end

endmodule
