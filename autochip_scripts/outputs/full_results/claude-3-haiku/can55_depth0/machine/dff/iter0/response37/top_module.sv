module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Set the initial value of q to an unknown or undefined state
    end

    always @(posedge clk) begin
        q = d; // Assign the value of d to the output register q on the rising edge of the clock
    end

endmodule
