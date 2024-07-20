module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

reg [255:0] next_q;
reg [15:0] row_above, row_below, row_curr;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    // Compute the next state of the game
    for (int i = 0; i < 16; i++) begin
        row_above = (i == 0) ? q[255:240] : q[(i*16)+15:i*16];
        row_curr = q[(i*16)+15:i*16];
        row_below = (i == 15) ? q[15:0] : q[((i+1)*16)-1:(i+1)*16-16];

        next_q[(i*16)+15:i*16] = (row_curr & (row_above | row_below)) | (~row_curr & ((row_above & row_below) | (row_above == 16'h0 & row_below == 16'h0)));
    end
end

endmodule
