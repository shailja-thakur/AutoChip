module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

    // State declarations
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        S10 = 3'b011,
        S11 = 3'b100,
        S20 = 3'b101,
        S21 = 3'b110,
        S22 = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = w ? S11 : S10;
            C: next_state = w ? S11 : S10;
            S10: next_state = w ? S21 : S20;
            S11: next_state = w ? S22 : S21;
            S20: next_state = B;
            S21: next_state = w ? C : B;
            S22: next_state = w ? B : C;
            default: next_state = A;  // Default state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 0;
        else begin
            case (state)
                S10: z <= 1;
                S11: z <= 1;
                S21: z <= 1;
                S22: z <= 1;
                default: z <= 0;
            endcase
        end
    end

endmodule
