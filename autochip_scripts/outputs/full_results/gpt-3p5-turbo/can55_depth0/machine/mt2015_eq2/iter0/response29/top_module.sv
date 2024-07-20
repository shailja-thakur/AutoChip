module top_module(
    input [1:0] A,
    input [1:0] B,
    output reg z);  // Added "reg" keyword for the output "z" to make it a reg type variable 

    always @(*) begin  // Added sensitivity list to the combinational logic
        if (A == B)  // Comparing A and B for equality
            z = 1;  // Setting z to 1 if A and B are equal
        else
            z = 0;  // Setting z to 0 if A and B are not equal
    end

endmodule
