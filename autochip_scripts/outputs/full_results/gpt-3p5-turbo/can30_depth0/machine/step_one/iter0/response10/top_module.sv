module top_module(
	output reg one);  // Added "reg" datatype for the output port

    // Assigning output one to a constant value of 1'b1
    always @(*)  // Sensitivity list updated
    begin
        one = 1'b1;
    end

endmodule
