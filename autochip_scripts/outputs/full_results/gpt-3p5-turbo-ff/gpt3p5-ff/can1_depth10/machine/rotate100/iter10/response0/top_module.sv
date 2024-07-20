module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);
    always @(posedge clk) begin
        if (load) begin
            q <= data; // Load data into output register
        end else begin
            if (ena == 2'b01) begin
                q <= {q[97:0], q[98], 1'b0}; // Shift q to the left
            end else if (ena == 2'b10) begin
                q <= {1'b0, q[99:1], q[0]}; // Shift q to the right
            end
        end
    end
endmodule
