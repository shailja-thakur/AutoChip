module top_module (
    input clk,
    input a,
    output reg q
);

reg prev_a;

always @(posedge clk) begin
    prev_a <= a; 

    case (q)
        0: if (prev_a == 1'b0) q <= 1'b1;
        1: begin
            if (prev_a == 1'b0) q <= 1'b0;
            if (prev_a == 1'b1) q <= 1'b1; // Update to '1' instead of '0'
        end
        default: q <= q;
    endcase
end

endmodule
