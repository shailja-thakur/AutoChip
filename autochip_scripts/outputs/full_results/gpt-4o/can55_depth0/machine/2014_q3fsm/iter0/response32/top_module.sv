module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {A, B, C, S10, S11, S20, S21, S22} state_t;
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always @(*) begin
        z = 1'b0;  // Assuming default output is 0
        case (current_state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
            end
            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
            end
            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
            end
            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
