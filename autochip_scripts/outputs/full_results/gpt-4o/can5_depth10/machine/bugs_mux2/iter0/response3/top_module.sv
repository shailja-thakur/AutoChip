module top_module (
    input wire sel,
    input wire [7:0] a,
    input wire [7:0] b,
    output reg [7:0] out
);

    always @(*) begin
        if (sel) 
            out = a;
        else
            out = b;
    end

endmodule
