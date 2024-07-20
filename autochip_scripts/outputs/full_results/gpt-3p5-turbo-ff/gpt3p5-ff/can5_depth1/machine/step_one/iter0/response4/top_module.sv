module top_module(
    output reg one);

    // always block to assign the value 1'b1 to output one
    always @(posedge clk)
    begin
        one <= 1'b1;
    end

endmodule
