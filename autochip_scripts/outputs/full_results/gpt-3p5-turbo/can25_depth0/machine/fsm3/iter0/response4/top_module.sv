module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state; // 2-bit register for state machine

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        case (state)
            2'b00: state <= (in) ? 2'b01 : 2'b00; // Next state based on input signal
            2'b01: state <= (in) ? 2'b01 : 2'b10; // Next state based on input signal
            2'b10: state <= (in) ? 2'b11 : 2'b00; // Next state based on input signal
            2'b11: state <= (in) ? 2'b01 : 2'b10; // Next state based on input signal
        endcase
    end
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Output set to 1 when state is D

endmodule
