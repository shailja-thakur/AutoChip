module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic[2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        S10 = 3'b011,
        S11 = 3'b100,
        S20 = 3'b101,
        S21 = 3'b110,
        S22 = 3'b111
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (s) ? B : A;
            B: next_state = (w) ? S11 : S10;
            C: next_state = (w) ? S11 : S10;
            S10: next_state = (w) ? S21 : S20;
            S11: next_state = (w) ? S22 : S21;
            S20: next_state = B;
            S21: next_state = (w) ? C : B;
            S22: next_state = (w) ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            // Define the output logic as per the requirement (z)
            // Here we default to zero as no other output logic is specified in the prompt.
            default: z = 1'b0;
        endcase
    end
    
endmodule
