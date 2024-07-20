module top_module (
    input clk,
    input resetn,
    input in,
    output reg out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            sr <= 4'b0; // Reset the shift register to all zeros
        end
        else begin
            sr <= {sr[2:0], in}; // Shift left by one bit and load input into LSB
            out <= sr[3]; // Output the MSB of the shift register
        end
    end

endmodule
