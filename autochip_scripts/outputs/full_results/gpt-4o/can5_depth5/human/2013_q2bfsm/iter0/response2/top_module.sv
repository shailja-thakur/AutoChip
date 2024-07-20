module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State Encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110,
        STATE_H = 3'b111
    } state_t;

    // State variables
    state_t state, next_state;
    reg [1:0] count;

    // Output Logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 1'b0;
            g <= 1'b0;
            count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == STATE_B) f <= 1'b1; else f <= 1'b0;
            if (state == STATE_G) g <= 1'b1; else if (state == STATE_H) g <= 1'b0;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            STATE_A: if (resetn) next_state = STATE_B; else next_state = STATE_A;
            STATE_B: next_state = STATE_C;
            STATE_C: if (x) next_state = STATE_D; else next_state = STATE_C;
            STATE_D: if (~x) next_state = STATE_E; else next_state = STATE_C;
            STATE_E: if (x) next_state = STATE_F; else next_state = STATE_C;
            STATE_F: next_state = STATE_G;
            STATE_G: if (y) next_state = STATE_G; else next_state = STATE_H;
            STATE_H: next_state = STATE_H;
            default: next_state = STATE_A;
        endcase
    end
endmodule
