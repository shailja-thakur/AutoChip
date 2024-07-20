module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state, next_state;

    // State definitions
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100,
               F = 3'b101;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;  // Reset to state A
        else
            state <= next_state;  // Update state on clock edge
    end

    // Next state logic - combinational logic block
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A;  // Safe default state
        endcase
    end

    // Output logic
    assign z = (state == E) || (state == F);

endmodule
