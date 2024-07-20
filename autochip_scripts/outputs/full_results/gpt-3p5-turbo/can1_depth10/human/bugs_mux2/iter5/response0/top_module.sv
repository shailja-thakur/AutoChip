module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    always @* begin
        if (sel)
            out = b; // Use blocking assignment for combinational logic
        else
            out = a; // Use blocking assignment for combinational logic
    end

endmodule
