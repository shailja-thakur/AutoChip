module top_module(
    output reg zero,
    input clk);

    always @(posedge clk) begin
        zero <= 0;
    end

endmodule
