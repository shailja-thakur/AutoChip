module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state encoding
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;

    reg [2:0] state, next_state;

    // State transition on clock edge
    always @(posedge clk) begin
        if (reset)
            state <= A; // reset to initial state A
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default to state A if something goes wrong
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1;
            default: z = 0;
        endcase
    end

endmodule
