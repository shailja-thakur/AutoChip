module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);
    always @(*) begin
        // Initialize min with one of the inputs, say 'a'
        min = a;
        // Compare 'min' with each input and update accordingly
        if (b < min) min = b;
        if (c < min) min = c;
        if (d < min) min = d;
    end
endmodule
