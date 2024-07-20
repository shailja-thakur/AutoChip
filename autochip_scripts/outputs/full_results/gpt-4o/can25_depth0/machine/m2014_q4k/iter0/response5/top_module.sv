module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr; // 4-bit shift register

    // Output is the most significant bit of the shift register
    assign out = sr[3];

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Reset the shift register to all zeros
            sr <= 4'b0000;
        end else begin
            // Shift left by one bit and load 'in' into the LSB
            sr <= {sr[2:0], in};
        end
    end
endmodule
