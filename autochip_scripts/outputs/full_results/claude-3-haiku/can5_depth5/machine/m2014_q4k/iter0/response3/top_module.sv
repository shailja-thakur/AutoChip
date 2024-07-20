module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0000; // Reset the shift register to all zeros
        end
        else begin
            sr <= {sr[2:0], in}; // Shift left by one bit and load the input into the least significant bit
            out <= sr[3]; // Output the most significant bit of the shift register
        end
    end

endmodule
