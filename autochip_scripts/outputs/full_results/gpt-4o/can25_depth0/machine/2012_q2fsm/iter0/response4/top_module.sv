module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // State encoding
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;

    reg [2:0] state, next_state;

    // Sequential block for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= A;  // Reset state to A
        end else begin
            state <= next_state;  // Move to next state
        end
    end

    // Combinational block for next state logic
    always @(*) begin
        case (state)
            A: next_state = w ? B : A;
            B: next_state = w ? C : D;
            C: next_state = w ? E : D;
            D: next_state = w ? F : A;
            E: next_state = w ? E : D;
            F: next_state = w ? C : D;
            default: next_state = A;  // Default to state A
        endcase
    end

    // Combinational block for output logic
    assign z = (state == E) || (state == F);

endmodule
