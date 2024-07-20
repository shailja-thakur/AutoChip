module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        S10 = 3'd3,
        S11 = 3'd4,
        S20 = 3'd5,
        S21 = 3'd6,
        S22 = 3'd7
    } state_t;
    
    state_t state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = w ? S11 : S10;
            S10: next_state = w ? S21 : S20;
            S11: next_state = w ? S22 : S21;
            S20: next_state = B;
            S21: next_state = w ? C : B;
            S22: next_state = w ? B : C;
            C: next_state = w ? S11 : S10;
            default: next_state = A; // default state (Reset condition)
        endcase
    end

    // Output logic for z
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            // Define output z based on the specific states
            // The specification did not provide details about z, assuming always 0 for now
            z <= 0;
        end
    end

endmodule
