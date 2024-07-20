module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg prev_a;

always @(posedge clock) begin
    // Update p
    p <= a;

    // Update q
    if (prev_a == 1'b1 && a == 1'b0) begin
        q <= 1'b1;
    end else begin
        q <= 1'b0;
    end

    // Update prev_a
    prev_a <= a;
end

endmodule
