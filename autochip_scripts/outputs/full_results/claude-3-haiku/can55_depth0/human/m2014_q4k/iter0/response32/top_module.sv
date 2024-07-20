module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (~resetn) begin
            shift_reg <= 4'b0; // Reset the shift register to 0 when resetn is low
        end
        else begin
            shift_reg <= {shift_reg[2:0], in}; // Shift the register left by 1 bit and insert the input 'in' at the rightmost bit
        end
    end

    assign out = shift_reg[3]; // Output the most significant bit of the shift register

endmodule
