module top_module(
    output reg zero
);

always @* begin
    zero = 1'b0; // Assign a constant low value to the output
end

endmodule
