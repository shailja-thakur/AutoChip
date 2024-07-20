module top_module(
    output reg one);  // Add "reg" keyword to declare "one" as a register

    always @(*)    // Use combinational logic for the output assignment
    begin
        one = 1'b1;
    end

endmodule
