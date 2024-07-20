module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b001; // Initialize state to A
    else
        state <= next_state; // Update state based on next_state

    case (state)
        3'b001: // State A
            if (x)
                next_state = 3'b010; // Next state is B
            else
                next_state = 3'b001; // Next state is A
        3'b010: // State B
            if (x)
                next_state = 3'b100; // Next state is E
            else
                next_state = 3'b010; // Next state is B
        3'b011: // State C
            if (x)
                next_state = 3'b010; // Next state is B
            else
                next_state = 3'b011; // Next state is C
        3'b100: // State D
            if (x)
                next_state = 3'b011; // Next state is C
            else
                next_state = 3'b010; // Next state is B
        3'b101: // State E
            if (x)
                next_state = 3'b101; // Next state is E
            else
                next_state = 3'b100; // Next state is D
        default: // Handle any other state
            next_state = 3'b000; // Next state is undefined
    endcase
end

always @(state) begin
    case (state)
        3'b101, 3'b100: // State D or E
            z = 1'b1; // Set output to high
        default:
            z = 1'b0; // Set output to low
    endcase
end

endmodule
