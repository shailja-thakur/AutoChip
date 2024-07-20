module top_module(
    output reg out
);

always @(*) begin
    out = 1'b0; // Assign 0 (logic low) to the output
end

endmodule
