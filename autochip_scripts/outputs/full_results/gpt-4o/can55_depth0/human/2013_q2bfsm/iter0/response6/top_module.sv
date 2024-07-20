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
        STATE_A = 3'b000,  // Initial state
        STATE_B = 3'b001,  // Set f = 1 for one cycle state
        STATE_C = 3'b010,  // Monitor x for 1, 0, 1 sequence state
        STATE_D = 3'b011,  // Set g = 1 and monitor y for 1 state
        STATE_E = 3'b100   // Maintain g = 1 state
    } state_t;

    state_t current_state, next_state;

    reg [1:0] y_monitor_count;     // Counter to monitor y within two clock cycles
    reg [2:0] x_sequence;          // Register to track the x sequence for 1, 0, 1 monitoring

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_monitor_count <= 0;
            x_sequence <= 3'b000;
        end else begin
            current_state <= next_state;

            // Output logic based on state transitions
            case (current_state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                end
                STATE_B: begin
                    f <= 1;
                end
                STATE_C: begin
                    f <= 0;
                    x_sequence <= {x_sequence[1:0], x};  // Shift x and track last 3 bits
                end
                STATE_D: begin
                    f <= 0;
                    g <= 1;
                    y_monitor_count <= y_monitor_count + 1;
                end
                STATE_E: begin
                    f <= 0;
                end
                default: begin
                    f <= 0;
                    g <= 0;
                end
            endcase

            // Reset output f in next clock cycle for STATE_B
            if (current_state == STATE_B) begin
                f <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (!resetn)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            STATE_B: next_state = STATE_C;
            STATE_C: begin
                if (x_sequence == 3'b101)  // Check if x sequence is 1, 0, 1
                    next_state = STATE_D;
                else
                    next_state = STATE_C;
            end
            STATE_D: begin
                if (y)
                    next_state = STATE_E;
                else if (y_monitor_count == 2)
                    next_state = STATE_A;  // Return to initial state if y is not 1 within 2 cycles
                else
                    next_state = STATE_D;
            end
            STATE_E: next_state = STATE_E;
            default: next_state = STATE_A;
        endcase
    end
endmodule
