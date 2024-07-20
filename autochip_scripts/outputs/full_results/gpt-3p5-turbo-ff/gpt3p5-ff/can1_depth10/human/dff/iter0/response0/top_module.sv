module top_module(
    input clk,
    input d,
    output reg q);

    // Declare and assign flip-flop
    always @(posedge clk)
    begin
        q <= d;
    end

endmodule
