module top_module(
    input clk,
    input d,
    output reg q);

    // Initialize q to unknown value
    initial begin
        q = 1'hx;
    end

    // Set q to the value of d at the rising edge of clk
    always @(posedge clk) begin
        q <= d;
    end
endmodule
