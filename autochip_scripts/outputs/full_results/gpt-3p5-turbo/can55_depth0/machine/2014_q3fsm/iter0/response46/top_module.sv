module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [3:0] {
        A,
        B,
        C,
        S11,
        S10,
        S21,
        S20,
        S22
    } state;

    reg [3:0] current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = current_state;
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
            S20: next_state = B;
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
            default: next_state = current_state;
        endcase
    end

    always_comb begin
        case (current_state)
            A: z = 0;
            default: z = 1;
        endcase
    end

endmodule
