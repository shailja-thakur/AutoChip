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
            q <= q << 1;  // Shift q left when ena is 01
        end else if (ena == 2'b10) begin
            q <= q >> 1;  // Shift q right when ena is 10
        end
    end

endmodule
