module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states using parameter
    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100,
              F = 3'b101;
    
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: next_state = (w) ? B : A;
            B: next_state = (w) ? C : D;
            C: next_state = (w) ? E : D;
            D: next_state = (w) ? F : A;
            E: next_state = (w) ? E : D;
            F: next_state = (w) ? C : D;
            default: next_state = A; // Default state
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == E || state == F) ? 1 : 0;
    end

endmodule
