module top_module(
    output zero, input clk);

    reg zero;

    always @(posedge clk) begin
        zero <= 0;
    end

endmodule
