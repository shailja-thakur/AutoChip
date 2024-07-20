module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

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

    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    always @(*) begin
        next_state = state; // default to stay in current state
        case (state)
            A: if (s) next_state = B;
            B: if (w) next_state = S11;
               else next_state = S10;
            C: if (w) next_state = S11;
               else next_state = S10;
            S10: if (w) next_state = S21;
                else next_state = S20;
            S11: if (w) next_state = S22;
                else next_state = S21;
            S20: next_state = B;
            S21: if (w) next_state = C;
                 else next_state = B;
            S22: if (w) next_state = B;
                 else next_state = C;
            default: next_state = A;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else begin
            case (state)
                S20: z <= 1'b1; // Active output when in state S20
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
