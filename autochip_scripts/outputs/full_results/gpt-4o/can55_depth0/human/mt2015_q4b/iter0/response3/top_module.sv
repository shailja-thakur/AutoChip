module top_module(
    input wire x,
    input wire y,
    output reg z);

    always @(*) begin
        if (x == 1'b0 && y == 1'b0)
            z = 1'b1;
        else if (x == 1'b1 && y == 1'b0)
            z = 1'b0;
        else if (x == 1'b0 && y == 1'b1)
            z = 1'b0;
        else if (x == 1'b1 && y == 1'b1)
            z = 1'b1;
        else
            z = 1'b0;  // default case
    end

endmodule
