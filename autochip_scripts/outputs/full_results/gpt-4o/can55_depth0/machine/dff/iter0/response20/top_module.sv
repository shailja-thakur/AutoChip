module top_module(
    input clk,
    input d,
    output reg q);

    initial begin
        q = 1'hx; // Initialize q to unknown value
    end

    always @(posedge clk) begin
        q <= d; // Update q with the value of d on the rising edge of clk
    end
endmodule
