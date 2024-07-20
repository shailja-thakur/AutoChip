module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    // Declare four D flip-flops in the shift register
    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (~resetn) begin
            // Synchronous active-low reset
            shift_reg <= 4'b0;
        end else begin
            // Shift operation
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    // Output is the last bit of the shift register
    assign out = shift_reg[3];

endmodule
