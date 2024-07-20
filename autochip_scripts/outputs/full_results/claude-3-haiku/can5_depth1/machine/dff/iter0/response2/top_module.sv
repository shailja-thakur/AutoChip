module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'bx; // Initialize the output register q to an unknown value
    end

    always @(posedge clk) begin
        q <= d; // Assign the input signal d to the output register q
    end

endmodule
