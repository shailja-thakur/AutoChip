module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    case (a)
        1'b0: q <= 1'b1;
        1'b1: q <= 1'b0;
        default: q <= q; // Hold the previous state
    endcase
end

endmodule
