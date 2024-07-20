module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

    reg [3:0] shift_reg; // 4-bit shift register

    always @(posedge clk) begin
        if (!resetn)
            shift_reg <= 4'b0; // Synchronous reset (active low)
        else
            shift_reg <= {shift_reg[2:0], in}; // Shift left and insert 'in' at LSB
    end

    assign out = shift_reg[3]; // Output the MSB of the shift register

endmodule
