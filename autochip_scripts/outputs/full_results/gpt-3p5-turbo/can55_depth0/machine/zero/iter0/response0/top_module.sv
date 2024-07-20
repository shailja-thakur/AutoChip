module top_module(
    output reg zero);  // Add reg keyword to declare a reg type output
    
    always @* begin  // Use combinational logic instead of continuous assignment
        zero = 0;  // Assign the value 0 to output zero
    end
    
endmodule
