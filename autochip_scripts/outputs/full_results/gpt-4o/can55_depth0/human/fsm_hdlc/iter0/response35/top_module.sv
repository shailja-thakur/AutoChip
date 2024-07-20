module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    // State encoding
    typedef enum reg [2:0] {
        STATE_IDLE      = 3'b000,
        STATE_1         = 3'b001,
        STATE_11        = 3'b010,
        STATE_111       = 3'b011,
        STATE_1111      = 3'b100,
        STATE_11111     = 3'b101,
        STATE_111110    = 3'b110,
        STATE_111111    = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (in) next_state = STATE_1;
                else next_state = STATE_IDLE;
            end
            STATE_1: begin
                if (in) next_state = STATE_11;
                else next_state = STATE_IDLE;
            end
            STATE_11: begin
                if (in) next_state = STATE_111;
                else next_state = STATE_IDLE;
            end
            STATE_111: begin
                if (in) next_state = STATE_1111;
                else next_state = STATE_IDLE;
            end
            STATE_1111: begin
                if (in) next_state = STATE_11111;
                else next_state = STATE_IDLE;
            end
            STATE_11111: begin
                if (in) next_state = STATE_111110;
                else next_state = STATE_IDLE;
            end
            STATE_111110: begin
                if (in) next_state = STATE_111111;
                else next_state = STATE_IDLE;
            end
            STATE_111111: begin
                if (in) next_state = STATE_111111; // Remain in error state
                else next_state = STATE_IDLE;
            end
            default: next_state = STATE_IDLE;
        endcase
    end

    // Sequential state and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;

            // Output decoding
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (next_state)
                STATE_IDLE: begin end
                STATE_1: begin end
                STATE_11: begin end
                STATE_111: begin end
                STATE_1111: begin end
                STATE_11111: begin
                    if (!in) disc <= 1; // Sequence 0111110 detected
                end
                STATE_111110: begin
                    if (!in) flag <= 1; // Sequence 01111110 detected
                end
                STATE_111111: begin
                    if (in) err <= 1; // Error sequence 01111111 detected
                end
            endcase
        end
    end

endmodule
