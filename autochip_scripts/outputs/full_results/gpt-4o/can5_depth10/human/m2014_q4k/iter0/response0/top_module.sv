module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] shift_reg;

    // Shift register logic
    always @(posedge clk) begin
        if (!resetn)
            shift_reg <= 4'b0000; // Active-low synchronous reset
        else
            shift_reg <= {shift_reg[2:0], in}; // Shift left and input new bit
    end

    assign out = shift_reg[3]; // Output the MSB of the shift register
endmodule
