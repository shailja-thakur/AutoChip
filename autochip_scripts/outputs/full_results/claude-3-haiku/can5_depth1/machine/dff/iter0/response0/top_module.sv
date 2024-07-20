module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Initialize the register signal q to an unknown value
    end

    always @(posedge clk) begin
        q <= d; // Assign the data signal d to the register signal q on the rising edge of the clock
    end

endmodule
