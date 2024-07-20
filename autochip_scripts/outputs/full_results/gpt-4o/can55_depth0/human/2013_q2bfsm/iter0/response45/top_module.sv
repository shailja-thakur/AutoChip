module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;

    reg [1:0] y_counter;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: next_state = resetn ? STATE_A : STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = x ? STATE_D : STATE_A;
            STATE_D: next_state = x ? STATE_E : STATE_A;
            STATE_E: next_state = x ? STATE_E : STATE_F;
            STATE_F: next_state = y ? STATE_E : (y_counter == 2 ? STATE_A : STATE_F);
            default: next_state = STATE_A;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (!resetn) begin
            state <= STATE_A;
            y_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (state == STATE_F && !y) 
                y_counter <= y_counter + 1;
            else 
                y_counter <= 2'b00;
        end
    end

    // Output logic
    always @(*) begin
        f = 0;
        g = 0;
        case (state)
            STATE_B: f = 1;
            STATE_E: g = 1;
            STATE_F: g = y ? 1 : (y_counter != 2);
        endcase
    end

endmodule
