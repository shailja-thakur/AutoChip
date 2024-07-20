module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    parameter IDLE   = 4'd0,
              ONE    = 4'd1,
              TWO    = 4'd2,
              THREE  = 4'd3,
              FOUR   = 4'd4,
              FIVE   = 4'd5,
              SIX    = 4'd6,
              SEVEN  = 4'd7,
              ERROR  = 4'd8;

    reg [3:0] state, next_state;

    // Sequential logic: state transition and output registers
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                IDLE, ONE, TWO, THREE, FOUR, FIVE: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                SIX: begin
                    if (!in) disc <= 1;
                    else disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                SEVEN: begin
                    if (!in) flag <= 1;
                    else flag <= 0;
                    disc <= 0;
                    err <= 0;
                end
                ERROR: begin
                    err <= 1;
                    disc <= 0;
                    flag <= 0;
                end
            endcase
        end
    end

    // Combinational logic: next state logic
    always @(*) begin
        case (state)
            IDLE: 
                next_state = in ? ONE : IDLE;
            ONE: 
                next_state = in ? TWO : IDLE;
            TWO: 
                next_state = in ? THREE : IDLE;
            THREE: 
                next_state = in ? FOUR : IDLE;
            FOUR: 
                next_state = in ? FIVE : IDLE;
            FIVE: 
                next_state = in ? SIX : IDLE;
            SIX: begin
                if (in)
                    next_state = SEVEN;
                else
                    next_state = IDLE; // Bit requires discard, go back to IDLE
            end
            SEVEN: begin
                if (in)
                    next_state = ERROR; // Move to error state if 7 consecutive 1s
                else
                    next_state = IDLE; // Flag detected, go back to IDLE
            end
            ERROR: 
                if (!in)
                    next_state = IDLE; // Exit error state only if we get a 0
                else
                    next_state = ERROR;
            default: 
                next_state = IDLE;
        endcase
    end
endmodule
