module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    typedef enum reg [2:0] {
        STATE_A,
        STATE_F,
        STATE_X0,
        STATE_X1,
        STATE_X2,
        STATE_G1,
        STATE_G_MONITOR1,
        STATE_G_MONITOR2
    } state_t;

    state_t current_state, next_state;
    reg [1:0] y_monitor_counter;

    // State transition
    always @(posedge clk) begin
        if (!resetn) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        next_state = current_state;
        f = 0;
        g = 0;
        case (current_state)
            STATE_A: begin
                next_state = resetn ? STATE_F : STATE_A;
            end
            STATE_F: begin
                f = 1;
                next_state = STATE_X0;
            end
            STATE_X0: begin
                if (x) next_state = STATE_X1;
            end
            STATE_X1: begin
                if (!x) next_state = STATE_X2;
            end
            STATE_X2: begin
                if (x) next_state = STATE_G1;
            end
            STATE_G1: begin
                g = 1;
                next_state = STATE_G_MONITOR1;
            end
            STATE_G_MONITOR1: begin
                g = 1;
                if (y) next_state = STATE_G1;
                else next_state = STATE_G_MONITOR2; 
            end
            STATE_G_MONITOR2: begin
                g = 1;
                if (y) next_state = STATE_G1;
                else next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            y_monitor_counter <= 0;
        end else begin
            case (current_state)
                STATE_F: f <= 1;
                STATE_G_MONITOR1, STATE_G_MONITOR2: begin
                    g <= 1;
                    y_monitor_counter <= y_monitor_counter + 1;
                    if (y) begin
                        g <= 1;
                        y_monitor_counter <= 0;
                    end else if (y_monitor_counter == 2) begin
                        g <= 0;
                    end
                end
                default: begin
                    f <= 0;
                    g <= 0;
                    y_monitor_counter <= 0;
                end
            endcase
        end
    end

endmodule
