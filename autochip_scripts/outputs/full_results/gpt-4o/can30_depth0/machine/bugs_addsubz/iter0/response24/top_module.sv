module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

always @(*) begin
    // Perform arithmetic operation based on do_sub signal
    if (do_sub) begin
        out = a - b;  // Subtraction
    end else begin
        out = a + b;  // Addition
    end

    // Set result_is_zero signal
    if (out == 8'd0) begin
        result_is_zero = 1'b1;
    end else begin
        result_is_zero = 1'b0;
    end
end

endmodule
