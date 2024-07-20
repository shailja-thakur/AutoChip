module top_module (
    input clk,
    input a,
    output reg q
);

reg prev_a;

always @(posedge clk) begin
    prev_a <= a;  // Store previous value of 'a' for comparison

    case (q)
        0: if (prev_a == 1'b0) q <= 1'b1;
        1: if (prev_a == 1'b0) q <= 1'b0;  // Update to '0' instead of '1'
        1: if (prev_a == 1'b1) q <= 1'b0;
        default: q <= q;
    endcase
end

endmodule
