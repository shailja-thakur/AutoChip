module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'd0;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == B || state == C || state == D) begin
                if (state == B) z <= 1'b0;
                w_count <= (w_count + w) % 3; // Count w occurrences mod 3
                if (state == D) z <= (w_count == 2); // Set z if exactly 2 w's in 3 cycles
            end
        end
    end

    always @(*) begin
        case (state)
            A: next_state = (s == 1) ? B : A;
            B: next_state = C;
            C: next_state = D;
            D: next_state = B;
            default: next_state = A;
        endcase
    end

endmodule
