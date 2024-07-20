module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {
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
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == B || state == C || state == D)
                w_count <= w_count + (w ? 1 : 0);
            if (state == D) begin
                z <= (w_count == 2);
                w_count <= 2'b00;
            end
        end
    end

    always @(*) begin
        case (state)
            A: if (s) next_state = B; else next_state = A;
            B: next_state = C;
            C: next_state = D;
            D: next_state = B;
            default: next_state = A;
        endcase
    end

endmodule
