module top_module(
    input in,
    output reg out);  // Added reg keyword for combinational assignment

    always @(*) begin  // Changed always block type to combinational
        out = in;  // Assign output with input value
    end

endmodule
