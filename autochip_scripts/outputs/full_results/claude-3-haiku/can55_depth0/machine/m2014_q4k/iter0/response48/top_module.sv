module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn) begin
            // Reset the shift register to all zeros
            sr <= 4'b0000;
        end else begin
            // Shift the register left by one bit and load the input into the least significant bit
            sr <= {sr[2:0], in};
        end
    end

    assign out = sr[3]; // Output the most significant bit of the shift register

endmodule
