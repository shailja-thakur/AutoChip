module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101,
        STATE_G = 3'b110
    } state_t;

    state_t state, next_state;
    reg [1:0] y_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
            y_count <= 2'b00;
        end else begin
            state <= next_state;
        end
    end

    always @(state or x or y or y_count) begin
        // Default outputs
        f = 1'b0;
        g = 1'b0;
        next_state = state;

        case (state)
            STATE_A: begin
                if (!resetn) begin
                    next_state = STATE_A;
                end else begin
                    f = 1;
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                if (x == 1) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (x == 0) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_D: begin
                if (x == 1) begin
                    next_state = STATE_E;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_E: begin
                g = 1;
                if (y == 1) begin
                    next_state = STATE_G;
                end else begin
                    if (y_count < 2) begin
                        next_state = STATE_F;
                    end else begin
                        next_state = STATE_A;
                    end
                end
            end
            STATE_F: begin
                g = 1;
                if (y == 1) begin
                    next_state = STATE_G;
                end else begin
                    y_count = y_count + 1;
                    if (y_count >= 2) begin
                        next_state = STATE_A;
                    end else begin
                        next_state = STATE_F;
                    end
                end
            end
            STATE_G: begin
                g = 1;
                next_state = STATE_G;
            end
        endcase
    end
endmodule
