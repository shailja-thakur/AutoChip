module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'b0000; // Asynchronous reset to zero
        end else if (load) begin
            q <= data; // Load data into shift register
        end else if (ena) begin
            q <= {1'b0, q[3:1]}; // Shift right and fill q[3] with zero
        end
    end
endmodule
