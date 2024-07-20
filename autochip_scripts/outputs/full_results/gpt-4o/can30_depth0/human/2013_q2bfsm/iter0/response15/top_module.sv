module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    // State encoding
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
    reg [2:0] x_history;
    reg [1:0] y_counter;

    // Output logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            state <= STATE_A;
        end else begin
            state <= next_state;
            case(state)
                STATE_A: f <= 0;
                STATE_B: f <= 1;
                STATE_C: f <= 0;
                STATE_F: g <= 1;
                STATE_G: g <= 0;
                default: ;
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case(state)
            STATE_A: if (!resetn) next_state = STATE_B;
            STATE_B: next_state = STATE_C;
            STATE_C: if (x) next_state = STATE_D;
            STATE_D: if (!x) next_state = STATE_E;
            STATE_E: if (x) next_state = STATE_F;
            STATE_F: if (y || y_counter == 2) next_state = (y ? STATE_F : STATE_G);
            STATE_G: next_state = STATE_A;
        endcase
    end

    // X and Y monitoring
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            x_history <= 0;
            y_counter <= 0;
        end else if (state == STATE_F) begin
            y_counter <= y_counter + 1;
        end else if (state == STATE_A) begin
            y_counter <= 0;
        end

        if (state == STATE_C || state == STATE_D || state == STATE_E) begin
            x_history <= {x_history[1:0], x};
        end else begin
            x_history <= 0;
        end
    end

    // Combine all
    assign f = (state == STATE_B);
    assign g = (state == STATE_F && y) || (state == STATE_G && !y);

endmodule
