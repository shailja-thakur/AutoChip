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
        STATE_F = 3'b101
    } state_t;

    state_t current_state, next_state;

    reg [1:0] y_counter; // Counter to track y input in STATE_E

    // State register (sequential)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Next state logic (combinational)
    always_comb begin
        next_state = current_state;
        f = 0;
        g = 0;

        case (current_state)
            STATE_A: begin
                if (resetn) 
                    next_state = STATE_B;
            end
            STATE_B: begin
                f = 1;
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x)
                    next_state = STATE_D;
                else
                    next_state = STATE_A; // In case of resetn de-asserted while x sequence begins
            end
            STATE_D: begin
                if (!x)
                    next_state = STATE_E;
                else
                    next_state = STATE_A;
            end
            STATE_E: begin
                if (x) begin
                    g = 1;
                    next_state = STATE_F;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_F: begin
                if (y_counter == 2) begin
                    if (!y)
                        g = 0;
                end else begin
                    if (y)
                        g = 1;
                    else
                        y_counter = y_counter + 1'b1;
                end
            end
            default:
                next_state = STATE_A;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            g <= 0;
            f <= 0;
        end else begin
            if (current_state == STATE_B)
                f <= 1;
            if (current_state == STATE_F) begin
                if (y_counter < 2) begin
                    g <= y;
                end else if (y_counter == 2 && !y) begin
                    g <= 0;
                end else begin
                    g <= 1;
                end
            end
        end
    end

    // y_counter reset and update
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            y_counter <= 0;
        end else if (current_state != STATE_F) begin
            y_counter <= 0;
        end
    end
endmodule
