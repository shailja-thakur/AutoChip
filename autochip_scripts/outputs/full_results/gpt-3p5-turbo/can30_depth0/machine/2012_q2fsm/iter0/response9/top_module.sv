module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state; // 3-bit register to hold the current state

// Next state logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000; // Initial state is A
    else begin
        case ({state, w})
            3'b000: state <= 3'b000; // State transition from A to A when w is 0
            3'b001: state <= 3'b010; // State transition from A to B when w is 1
            3'b010: state <= 3'b100; // State transition from B to C when w is 1
            3'b011: state <= 3'b110; // State transition from C to E when w is 1
            3'b100: state <= 3'b001; // State transition from D to A when w is 0
            3'b101: state <= 3'b110; // State transition from E to E when w is 1
            3'b110: state <= 3'b100; // State transition from F to C when w is 1
            default: state <= 3'b000; // Default state transition is A to A when w is 0
        endcase
    end
end

// Output logic
assign z = (state == 3'b100) || (state == 3'b110); // Set z to 1 when the state is E or F

endmodule
