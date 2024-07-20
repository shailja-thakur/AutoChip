module top_module (
	input clk,
	input resetn,
	input in,
	output reg out
);

    reg [3:0] sr; // 4-bit shift register

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            sr <= 4'b0000; // Reset register to all zeros
        else
            sr <= {sr[2:0], in}; // Shift left and load input into LSB
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            out <= 1'b0; // Reset output to 0
        else
            out <= sr[3]; // Output the MSB of the register
    end

endmodule
