module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] count; // Counter for '1's in three clock cycles in state B

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
            count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_B || state == STATE_C || state == STATE_D) begin
                if (state != STATE_B) begin
                    count <= count + w;
                end else begin
                    count <= 0;
                end
            end
            // Output z is set based on the counter value
            if (state == STATE_D) begin
                if (count == 2) begin
                    z <= 1;
                end else begin
                    z <= 0;
                end
            end else begin
                z <= 0;
            end
        end
    end

    always_comb begin
        case (state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = STATE_D;
            STATE_D: next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end
endmodule
