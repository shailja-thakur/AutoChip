module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
wire next_state;

// Initialize state to A
initial begin
    state = 2'b00;
end

// Sequential block
always @(posedge clk or posedge reset)
begin
    if (reset == 1) begin
        state <= 2'b00; // Reset state to A
    end else begin
        state <= next_state; // Transition to next state
    end
end

// Combinational block
assign next_state = (state == 2'b00 && in == 1) ? 2'b01 : // State A transitions
                  (state == 2'b01 && in == 1) ? 2'b01 : // State B transitions
                  (state == 2'b01 && in == 0) ? 2'b10 : // State B transitions
                  (state == 2'b10 && in == 1) ? 2'b11 : // State C transitions
                  (state == 2'b10 && in == 0) ? 2'b00 : // State C transitions
                  (state == 2'b11 && in == 1) ? 2'b01 : // State D transitions
                  (state == 2'b11 && in == 0) ? 2'b10 : // State D transitions
                  state; // Default to current state

// Output logic
assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
