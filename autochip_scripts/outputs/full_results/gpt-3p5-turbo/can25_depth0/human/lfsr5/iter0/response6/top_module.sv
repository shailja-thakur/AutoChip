module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

// Define the internal signals
reg [4:0] feedback;
reg [4:0] next_feedback;

// Synchronous reset
always @(posedge clk) begin
    if (reset)
        feedback <= 1;
    else
        feedback <= next_feedback;
end

// Calculate next state based on taps at bit positions 5 and 3
always @(posedge clk) begin
    next_feedback[4] <= feedback[3];
    next_feedback[3] <= feedback[2] ^ feedback[1] ^ feedback[0];
    next_feedback[2] <= feedback[3];
    next_feedback[1] <= feedback[2];
    next_feedback[0] <= feedback[1];
end

// Output the current feedback value
assign q = feedback;

endmodule
