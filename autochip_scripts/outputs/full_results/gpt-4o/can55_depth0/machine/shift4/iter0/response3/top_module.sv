module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset: set output register to 0
        q <= 4'b0000;
    end else if (load) begin
        // Load signal active: load data input into output register
        q <= data;
    end else if (ena) begin
        // Enable signal active: shift output register left by 1 bit
        q <= q << 1;
    end
end

endmodule
