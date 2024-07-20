module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

reg [3:0] sr; // 4-bit shift register

always @(posedge clk) begin
    if (~resetn) // Active-low reset
        sr <= 4'b0000; // Reset to all zeros
    else
        sr <= {sr[2:0], in}; // Shift left and load input
end

assign out = sr[3]; // Output is the MSB of the register

endmodule
