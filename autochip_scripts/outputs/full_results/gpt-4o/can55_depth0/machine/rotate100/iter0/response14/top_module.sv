module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);
    always @(posedge clk) begin
        if (load) begin
            // Load the data into the output register when load is high
            q <= data;
        end else if (ena == 2'h1) begin
            // Shift the output register to the left when enable is 1
            q <= q << 1;
        end else if (ena == 2'h2) begin
            // Shift the output register to the right when enable is 2
            q <= q >> 1;
        end
    end
endmodule
