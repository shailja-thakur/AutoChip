module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum bit [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C1 = 2'b10,
        STATE_C2 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count; // Counter to keep track of the number of 1s in three cycles

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        z = 1'b0; // Default the output to zero
        case (state)
            STATE_A: begin
                if (s == 1'b1) begin
                    next_state = STATE_B;
                end
            end

            STATE_B: begin
                next_state = STATE_C1;
            end

            STATE_C1: begin
                if (w == 1'b1) w_count = w_count + 2'b01;
                next_state = STATE_C2;
            end

            STATE_C2: begin
                if (w == 1'b1) w_count = w_count + 2'b01;
                if (next_state == STATE_C2) begin
                    if (w_count == 2'b10) begin
                        z = 1'b1;
                    end
                    next_state = STATE_B;
                    w_count = 2'b00; // reset the counter
                end
            end
        endcase
    end

endmodule
