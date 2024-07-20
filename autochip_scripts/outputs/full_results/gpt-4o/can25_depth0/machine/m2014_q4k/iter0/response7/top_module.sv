module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    // 4-bit shift register
    reg [3:0] sr;

    // Assign the most significant bit of sr to out
    assign out = sr[3];

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Reset the register to all zeros
            sr <= 4'b0000;
        end else begin
            // Shift left and load input into the least significant bit
            sr <= {sr[2:0], in};
        end
    end
endmodule
