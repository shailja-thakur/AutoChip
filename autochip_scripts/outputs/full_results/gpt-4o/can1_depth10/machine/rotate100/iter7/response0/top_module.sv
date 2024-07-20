module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;  // Load data into q when load is high
        end else if (ena == 2'b01) begin
            q <= {q[98:0], q[99]};  // Rotate q left one bit
        end else if (ena == 2'b10) begin
            q <= {q[0], q[99:1]};  // Rotate q right one bit
        end
    end

endmodule
