module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define the states of the FSM
    localparam [1:0] STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk, negedge resetn) begin
        if (!resetn) begin
            state <= STATE_A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (resetn) begin
                    next_state = STATE_B;
                end else begin
                    next_state = STATE_A;
                end
            end
            STATE_B: begin
                if (x == 1 && next_state == STATE_C) begin
                    next_state = STATE_C;
                end else begin
                    next_state = STATE_B;
                end
            end
            STATE_C: begin
                if (x == 0 && next_state == STATE_D) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_C;
                end
            end
            STATE_D: begin
                if (x == 1 && y == 1) begin
                    next_state = STATE_D;
                end else if (x == 1 && y == 0) begin
                    next_state = STATE_D;
                end else begin
                    next_state = STATE_A;
                end
            end
            default: begin
                next_state = STATE_A;
            end
        endcase
    end

    // Output logic
    always @(posedge clk, negedge resetn) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
        end else begin
            case (state)
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
                    g <= 0;
                end
                STATE_D: begin
                    f <= 0;
                    g <= 1;
                end
                default: begin
                    f <= 0;
                    g <= 0;
                end
            endcase
        end
    end

endmodule
