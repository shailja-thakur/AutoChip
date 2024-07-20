module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'bx; // Initializing q to unknown state
    end

    always @(posedge clk) begin
        q <= d; // Set q to the value of d at the rising edge of clk
    end

endmodule
