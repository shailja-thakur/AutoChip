module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'bx; // Initialize q to unknown value
    end

    always @(posedge clk) begin
        q <= d; // Assign the value of d to q on the rising edge of clk
    end

endmodule
