module top_module (
    input clk,
    input x,
    output z
);
    reg [2:0] s = 3'b000;

    always @(posedge clk) begin
        s[0] <= x | ~s[0];
        s[1] <= x & ~s[1];
        s[2] <= x ^ s[2];
    end

    assign z = ~(s[0] | s[1] | s[2]);

endmodule
