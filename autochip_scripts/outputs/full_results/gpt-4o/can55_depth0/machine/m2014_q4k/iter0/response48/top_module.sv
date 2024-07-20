module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    // 4-bit register to store data
    reg [3:0] sr;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Reset the register to all zeros
            sr <= 4'b0000;
        end else begin
            // Shift left and load input into LSB
            sr <= {sr[2:0], in};
        end
    end

    // Output taken from the most significant bit of the register
    assign out = sr[3];

endmodule
