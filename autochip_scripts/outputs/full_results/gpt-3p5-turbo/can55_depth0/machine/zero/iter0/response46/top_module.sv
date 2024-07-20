module top_module(
    output reg zero = 0); // Add reg keyword and initialize zero to 0

always @(posedge clk) // Add a clock signal for synchronous operation
begin
    zero <= 0; // Assign the value 0 to zero
end

endmodule
