module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);
    // Create a flip flop and connect its inputs and outputs
    always_ff @(posedge clk or posedge ar) // Use always_ff instead of always @(posedge clk)
    if (ar) // Use if statement to handle asynchronous reset
        q <= 1'b0;
    else // Use else to handle the non-reset condition
        q <= d;
endmodule
