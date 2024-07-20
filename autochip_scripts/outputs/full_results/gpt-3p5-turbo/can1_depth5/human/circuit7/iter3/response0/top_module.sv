module top_module (
    input clk,
    input a,
    output reg q
);

reg prev_q; // Add a flip-flop to store the previous value of q
reg prev_a;

always @(posedge clk) begin
    prev_a <= a;
    prev_q <= q; // Store the previous value of q

    case (prev_q) // Use the previous value of q in the case statement
        0: if (prev_a == 1'b0) q <= 1'b1;
        1: begin
            if (prev_a == 1'b0) q <= 1'b0;
            if (prev_a == 1'b1) q <= 1'b1;
        end
        default: q <= q;
    endcase
end

endmodule
