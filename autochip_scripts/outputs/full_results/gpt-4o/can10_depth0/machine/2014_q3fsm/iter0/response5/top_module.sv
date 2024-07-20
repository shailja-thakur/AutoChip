module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        S10 = 3'd3,
        S11 = 3'd4,
        S20 = 3'd5,
        S21 = 3'd6,
        S22 = 3'd7
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
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
            default: begin
                next_state = A;
            end
        endcase
    end

    // Example output logic; Adjust as needed for your application
    always @(*) begin
        z = (current_state == S10 || current_state == S11 || current_state == S20 || current_state == S21 || current_state == S22);
    end

endmodule
