module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define states
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        S10 = 3'b011,
        S11 = 3'b100,
        S20 = 3'b101,
        S21 = 3'b110,
        S22 = 3'b111
    } state_t;
    
    // State registers
    state_t state, next_state;

    // State transition on clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
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

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            z <= (state == S10 || state == S11 || state == S20 || state == S21 || state == S22);
        end
    end

endmodule
