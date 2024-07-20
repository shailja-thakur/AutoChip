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
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            A: begin
                if (s == 1) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (w == 1) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            C: begin
                if (w == 1) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (w == 1) begin
                    next_state = S21;
                end else begin
                    next_state = S20;
                end
            end
            S11: begin
                if (w == 1) begin
                    next_state = S22;
                end else begin
                    next_state = S21;
                end
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w == 1) begin
                    next_state = C;
                end else begin
                    next_state = B;
                end
            end
            S22: begin
                if (w == 1) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    always_comb begin
        z = (state == S21 || state == S22);  // Example: you can define z based on your requirements
    end

endmodule
