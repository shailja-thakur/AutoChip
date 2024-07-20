module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

// Create a counter variable to hold the current value of the counter
reg [3:0] counter;

always @(posedge clk) begin
    // Reset the counter when the reset input is active high
    if (reset)
        counter <= 4'b0;
    // Increment the counter when the slowena input is high
    else if (slowena)
        counter <= counter + 1;
end

// Assign the value of the counter to the output q
assign q = counter;

endmodule
