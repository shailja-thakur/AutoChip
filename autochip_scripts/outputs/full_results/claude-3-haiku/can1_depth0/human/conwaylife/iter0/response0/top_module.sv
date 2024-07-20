module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

`define ROW_SIZE 16
`define GRID_SIZE 256

reg [7:0] neighbors[`GRID_SIZE-1:0];

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        for (int i = 0; i < `GRID_SIZE; i++) begin
            int x = i % `ROW_SIZE;
            int y = i / `ROW_SIZE;
            neighbors[i] = 0;

            // Count neighbors
            if (x > 0)           neighbors[i] += q[i-1];
            if (x < `ROW_SIZE-1) neighbors[i] += q[i+1];
            if (y > 0)           neighbors[i] += q[i-`ROW_SIZE];
            if (y < `ROW_SIZE-1) neighbors[i] += q[i+`ROW_SIZE];
            if (x > 0 && y > 0)           neighbors[i] += q[i-`ROW_SIZE-1];
            if (x < `ROW_SIZE-1 && y > 0) neighbors[i] += q[i-`ROW_SIZE+1];
            if (x > 0 && y < `ROW_SIZE-1) neighbors[i] += q[i+`ROW_SIZE-1];
            if (x < `ROW_SIZE-1 && y < `ROW_SIZE-1) neighbors[i] += q[i+`ROW_SIZE+1];

            // Update state
            case (neighbors[i])
                0, 1: q[i] <= 0;
                2: q[i] <= q[i];
                3: q[i] <= 1;
                default: q[i] <= 0;
            endcase
        end
    end
end

endmodule
