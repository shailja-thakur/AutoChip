module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    typedef enum reg [2:0] {
        A,
        B,
        C,
        S10,
        S11,
        S20,
        S21,
        S22
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w) next_state = S11;
                else next_state = S10;
            end
            C: begin
                if (w) next_state = S11;
                else next_state = S10;
            end
            S10: begin
                if (w) next_state = S21;
                else next_state = S20;
            end
            S11: begin
                if (w) next_state = S22;
                else next_state = S21;
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w) next_state = C;
                else next_state = B;
            end
            S22: begin
                if (w) next_state = B;
                else next_state = C;
            end
            default: next_state = A; 
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) state <= A;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == S20) ? 1'b1 : 1'b0;
    end

endmodule
