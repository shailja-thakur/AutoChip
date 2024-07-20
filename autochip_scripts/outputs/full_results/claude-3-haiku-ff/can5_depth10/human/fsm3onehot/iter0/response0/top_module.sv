module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

wire stateA, stateB, stateC, stateD;
assign stateA = state[0];
assign stateB = state[1];
assign stateC = state[2];
assign stateD = state[3];

// Next state logic
always @(*) begin
    case(state)
        4'b0001: next_state = (in) ? 4'b0010 : 4'b0001; // State A
        4'b0010: next_state = (in) ? 4'b0010 : 4'b0100; // State B
        4'b0100: next_state = (in) ? 4'b1000 : 4'b0001; // State C
        4'b1000: next_state = (in) ? 4'b0010 : 4'b0100; // State D
        default: next_state = 4'b0001; // Default to state A
    endcase
end

// Output logic
assign out = stateD & in;

endmodule
