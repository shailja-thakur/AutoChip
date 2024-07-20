module top_module(
    input [1:0] A,
    input [1:0] B,
    output reg z);  // added 'reg' keyword for output

    always @(*) begin  // added always block
        if (A == B)  // added comparison for A and B
            z = 1;
        else
            z = 0;
    end

endmodule
