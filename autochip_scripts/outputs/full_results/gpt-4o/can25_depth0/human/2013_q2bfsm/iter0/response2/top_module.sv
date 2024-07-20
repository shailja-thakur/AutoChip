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
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] y_counter;

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 1'b0;
            g <= 1'b0;
            y_counter <= 2'b00;
        end else begin
            case (next_state)
                STATE_A: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    y_counter <= 2'b00;
                end
                STATE_B: f <= 1'b1;
                STATE_C,
                STATE_D,
                STATE_E: f <= 1'b0;
                STATE_F: g <= 1'b1;
                STATE_G: g <= 1'b0;
            endcase
            
            if (state == STATE_F && !g) begin
                if (y == 1'b1)
                    g <= 1'b1;
                else if (y_counter < 2'b10)
                    y_counter <= y_counter + 1;
                else
                    g <= 1'b0;
            end
        end
    end

    always_comb begin
        case (state)
            STATE_A: next_state = resetn ? STATE_B : STATE_A;
            STATE_B: next_state = STATE_C;
            STATE_C: next_state = (x == 1'b1) ? STATE_D : STATE_C;
            STATE_D: next_state = (x == 1'b0) ? STATE_E : STATE_D;
            STATE_E: next_state = (x == 1'b1) ? STATE_F : STATE_E;
            STATE_F: next_state = (y == 1'b1 && y_counter < 2'b01) ? STATE_F : STATE_G;
            STATE_G: next_state = STATE_G;
            default: next_state = STATE_A;
        endcase
    end
endmodule
