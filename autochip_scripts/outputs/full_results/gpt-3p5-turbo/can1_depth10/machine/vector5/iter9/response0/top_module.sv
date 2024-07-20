module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output reg [24:0] out
);

    always @(a, b, c, d, e) begin
        out = { {5{~a}}, {5{~b}}, {5{~c}}, {5{~d}}, {5{~e}} } ^ { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    end

endmodule
