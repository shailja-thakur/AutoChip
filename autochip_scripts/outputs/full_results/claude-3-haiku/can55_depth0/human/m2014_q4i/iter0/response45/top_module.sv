module top_module(
    output reg out
);

always @(*) begin
    out = 1'b0; // Drive the output to 0 (logic low)
end

endmodule
