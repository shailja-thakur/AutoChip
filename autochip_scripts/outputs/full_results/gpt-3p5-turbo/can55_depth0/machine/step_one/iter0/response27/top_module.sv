module top_module(
    output reg one);  // added 'reg' type for output one

    always @(posedge clk) begin  // added always block and posedge clk
        one <= 1'b1;  // assign constant value 1 to output one
    end

endmodule
