module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state; // register to hold the current state
    reg [2:0] next_state; // register to hold the next state

    // State transition table
    always @(state or w)
        case(state)
            3'b000:  next_state = w ? 3'b100 : 3'b000; // A (0)
            3'b100:  next_state = w ? 3'b001 : 3'b011; // B (0)
            3'b001:  next_state = w ? 3'b101 : 3'b010; // C (0)
            3'b010:  next_state = w ? 3'b101 : 3'b011; // D (0)
            3'b101:  next_state = w ? 3'b101 : 3'b010; // E (1)
            3'b011:  next_state = w ? 3'b001 : 3'b010; // F (1)
            default: next_state = 3'b000;
        endcase

    // State flip-flop
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 3'b000; // reset to state A
        else
            state <= next_state; // update the state based on next_state
    end

    // FSM output
    always @(state)
        case(state)
            3'b000: z = 1'b0; // output 0 in state A (0)
            3'b100: z = 1'b0; // output 0 in state B (0)
            3'b001: z = 1'b1; // output 1 in state C (0)
            3'b010: z = 1'b0; // output 0 in state D (0)
            3'b101: z = 1'b1; // output 1 in state E (1)
            3'b011: z = 1'b0; // output 0 in state F (1)
            default: z = 1'b0;
        endcase

endmodule
