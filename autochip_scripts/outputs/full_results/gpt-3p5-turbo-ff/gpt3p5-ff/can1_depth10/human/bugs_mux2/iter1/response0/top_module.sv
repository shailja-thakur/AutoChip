module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);
    
    always @*
    begin
        if (sel)
            out <= b; // change assignment operator to non-blocking (<=)
        else
            out <= a; // change assignment operator to non-blocking (<=)
    end

endmodule
