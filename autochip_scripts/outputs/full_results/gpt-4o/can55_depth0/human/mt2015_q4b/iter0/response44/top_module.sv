module top_module(
    input wire x,
    input wire y,
    output reg z);

    always @(*) begin
        if(x & y)
            z = 1;
        else if(~x & y)
            z = 0;
        else if(x & ~y)
            z = 0;
        else
            z = 1;
    end
endmodule
