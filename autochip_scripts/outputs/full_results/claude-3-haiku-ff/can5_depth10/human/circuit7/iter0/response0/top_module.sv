module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    case (a)
        1'b0: q <= 1'b1; // When a is 0, set q to 1
        1'b1: q <= 1'b0; // When a is 1, set q to 0
    endcase
end

endmodule
