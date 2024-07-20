module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] sr;  // 4-bit shift register

    // Assign output to the most significant bit of the shift register
    assign out = sr[3];

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            sr <= 4'b0000;  // Reset shift register to all zeros
        end else begin
            sr <= {sr[2:0], in};  // Shift left and load input into LSB
        end
    end
endmodule
