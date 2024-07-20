module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

    always @(*) begin
        if (sel == 1'b0)
            out = a;
        else
            out = b;
    end

endmodule
