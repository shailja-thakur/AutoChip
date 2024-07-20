module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define the states of the finite state machine
    localparam STATE_A = 2'd0;
    localparam STATE_B = 2'd1;
    localparam STATE_C = 2'd2;
    localparam STATE_D = 2'd3;

    // Register to store the current state
    reg [1:0] current_state, next_state;

    // Register to store the previous two values of x
    reg [1:0] x_history;

    // Register to store the count of clock cycles since y became 1
    reg [1:0] y_count;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Reset the FSM to the beginning state
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_history <= 0;
            y_count <= 0;
        end else begin
            // Update the current state
            current_state <= next_state;

            // Update the output signals
            case (current_state)
                STATE_A: begin
                    f <= 0;
                    g <= 0;
                end
                STATE_B: begin
                    f <= 1;
                    g <= 0;
                end
                STATE_C: begin
                    f <= 0;
                    g <= 1;
                end
                STATE_D: begin
                    f <= 0;
                    g <= 1;
                end
            endcase

            // Update the x history and y count
            x_history <= {x_history[0], x};
            if (y) begin
                y_count <= 0;
            end else begin
                y_count <= y_count + 1;
            end
        end
    end

    always @(*) begin
        // Determine the next state based on the current state and inputs
        case (current_state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (x_history == 2'b101) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (y_count == 2'b10) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_D: begin
                next_state = STATE_D;
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

endmodule
