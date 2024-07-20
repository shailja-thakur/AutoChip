module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr;

    always @(posedge clk) begin
        if (resetn == 1'b0) begin
            sr <= 4'b0000;         // Reset the register to all zeros
        end else begin
            sr <= {sr[2:0], in};   // Shift left by one bit and load input into LSB
        end
    end

    assign out = sr[3];              // Output taken from MSB

endmodule
