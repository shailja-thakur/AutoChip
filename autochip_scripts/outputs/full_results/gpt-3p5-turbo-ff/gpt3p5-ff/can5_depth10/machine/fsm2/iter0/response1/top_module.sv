module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(*) begin
    case(state)
        2'b00: next_state = j ? 2'b01 : 2'b00; // If state is A, next state depends on j
        2'b01: next_state = k ? 2'b00 : 2'b01; // If state is B, next state depends on k
        default: next_state = 2'b00;
    endcase
end

always @(posedge clk) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        state <= next_state; // Update state to next state
    end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out high if state is B, otherwise low

endmodule
