module top_module(
    input clk,
    input d,
    output reg q
);

initial begin
    q = 1'bx; // Initialize q to an unknown value
end

always @(posedge clk) begin
    q <= d; // Assign the input data signal d to the output register q
end

endmodule
