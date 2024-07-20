module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [3:0] {
        A    = 4'b0000,
        B    = 4'b0001,
        C    = 4'b0010,
        S10  = 4'b0011,
        S11  = 4'b0100,
        S20  = 4'b0101,
        S21  = 4'b0110,
        S22  = 4'b0111
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
    always @(*) begin
        case (current_state)
            A:   next_state = s ? B : A;
            B:   next_state = w ? S11 : S10;
            C:   next_state = w ? S11 : S10;
            S10: next_state = w ? S21 : S20;
            S11: next_state = w ? S22 : S21;
            S20: next_state = B;
            S21: next_state = w ? C : B;
            S22: next_state = w ? B : C;
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            z <= 0;
        end else begin
            current_state <= next_state;
            z <= (current_state == S10 || current_state == S11 || current_state == S20 || current_state == S21 || current_state == S22);
        end
    end

endmodule
