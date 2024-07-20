module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg[2:0] {
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
        // Default output and next state
        z = 1'b0;
        next_state = state;

        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
                z = 0;
            end

            B: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
                z = 1'b0;
            end

            C: begin
                if (w)
                    next_state = S11;
                else
                    next_state = S10;
                z = 1'b0;
            end

            S10: begin
                if (w)
                    next_state = S21;
                else
                    next_state = S20;
                z = 1'b1;
            end

            S11: begin
                if (w)
                    next_state = S22;
                else
                    next_state = S21;
                z = 1'b1;
            end

            S20: begin
                next_state = B;
                z = 1'b0;
            end

            S21: begin
                if (w)
                    next_state = C;
                else
                    next_state = B;
                z = 1'b1;
            end

            S22: begin
                if (w)
                    next_state = B;
                else
                    next_state = C;
                z = 1'b1;
            end

            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end
endmodule
