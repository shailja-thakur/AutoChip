module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    always @(*) begin
        if (sel == 1'b0) begin
            out = a;
        end else begin
            out = b;
        end
    end

endmodule
