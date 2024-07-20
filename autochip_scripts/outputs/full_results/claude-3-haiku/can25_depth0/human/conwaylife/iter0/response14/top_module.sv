module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

wire [255:0] next_state;

// Compute next state
generate
    genvar i;
    for (i = 0; i < 256; i = i + 1) begin : row
        wire [7:0] neighbors;
        
        // Compute neighbors for each cell
        assign neighbors[0] = q[(i - 16 + 256) % 256];
        assign neighbors[1] = q[(i - 15 + 256) % 256];
        assign neighbors[2] = q[(i - 1 + 256) % 256];
        assign neighbors[3] = q[(i + 1) % 256];
        assign neighbors[4] = q[(i + 15) % 256];
        assign neighbors[5] = q[(i + 16) % 256];
        assign neighbors[6] = q[(i - 14 + 256) % 256];
        assign neighbors[7] = q[(i + 17) % 256];
        
        // Compute next state based on rules
        assign next_state[i] = (q[i] & (neighbors[1] + neighbors[2] + neighbors[3] == 2 || neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7] == 3))
                            | (~q[i] & neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7] == 3);
    end
endgenerate

// Update state
always @(posedge clk) begin
    if (load) q <= data;
    else q <= next_state;
end

endmodule
