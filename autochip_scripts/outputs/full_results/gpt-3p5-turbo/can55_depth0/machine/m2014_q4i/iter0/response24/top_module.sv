module top_module(
    output reg out);

    // Output assignment
    always @(posedge clk) begin
        out <= 0;
    end

endmodule
