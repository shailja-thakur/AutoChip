module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define states
    typedef enum reg [2:0] {
        STATE_A,     // Initial state
        STATE_B,     // State after resetn is de-asserted, f = 1 for one clock cycle
        STATE_C,     // Waiting for x=1,0,1 sequence
        STATE_D,     // g=1, waiting for y=1
        STATE_E      // Permanent g state
    } state_t;

    state_t state, next_state;
    reg [1:0] x_sequence;
    reg [1:0] y_monitor;

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            STATE_A: begin
                if (resetn == 1) begin
                    next_state = STATE_B;
                end
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                if (x_sequence == 2'b101) begin
                    next_state = STATE_D;
                end
            end
            STATE_D: begin
                if (y == 1) begin
                    next_state = STATE_E;
                end else if (y_monitor == 2'b10) begin
                    next_state = STATE_E;
                end 
            end
            STATE_E: begin
                // Stays in STATE_E until reset
            end
        endcase
    end

    // Output logic and state update
    always @(posedge clk) begin
        if (!resetn) begin
            state <= STATE_A;
            f <= 0;
            g <= 0;
            x_sequence <= 2'b00;
            y_monitor <= 2'b00;
        end else begin
            state <= next_state;
            case (next_state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                end
                STATE_B: begin
                    f <= 1;
                end
                STATE_C: begin
                    f <= 0;
                    x_sequence <= {x_sequence[0], x};
                end
                STATE_D: begin
                    g <= 1;
                    y_monitor <= {y_monitor[0], 1'b1};
                end
                STATE_E: begin
                    // Maintain g
                end
            endcase
        end
    end

endmodule
