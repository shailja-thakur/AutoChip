module top_module(
    output zero, 
    input clk);

    always @(posedge clk) begin
        zero <= 0;
    end

endmodule
