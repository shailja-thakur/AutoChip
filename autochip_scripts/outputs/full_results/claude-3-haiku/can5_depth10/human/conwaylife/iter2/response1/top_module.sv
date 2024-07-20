module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

integer i;

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute the next state of the game
        for (i = 0; i < 256; i = i + 16) begin
            // Wrap-around the grid
            q[i+15:i] <= {q[i+14:i], q[i+15]};
        end

        // Apply the game rules
        for (i = 0; i < 256; i = i + 16) begin
            // Count the number of neighbors
            q[i+15:i] <= (q[i+15:i] == 16'b0) ? (q[i+14:i] & q[i+13:i]) :
                        (q[i+15:i] == 16'b1) ? (q[i+15:i] | (~q[i+14:i] & ~q[i+13:i])) :
                        (q[i+15:i] == 16'b10) ? q[i+15:i] : 16'b0;
        end
    end
end

endmodule
