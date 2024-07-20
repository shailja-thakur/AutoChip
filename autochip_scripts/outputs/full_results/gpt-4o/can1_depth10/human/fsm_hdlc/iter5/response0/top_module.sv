module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    parameter IDLE   = 3'd0,
              ONE    = 3'd1,
              TWO    = 3'd2,
              THREE  = 3'd3,
              FOUR   = 3'd4,
              FIVE   = 3'd5,
              SIX    = 3'd6,
              SEVEN  = 3'd7;

    reg [2:0] state, next_state;
    reg disc_next, flag_next, err_next;

    // Sequential logic: state transition and output registers
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            state <= next_state;
            disc <= disc_next;
            flag <= flag_next;
            err <= err_next;
        end
    end

    // Combinational logic: next state logic and output control
    always @(*) begin
        // Default output values
        disc_next = 1'b0;
        flag_next = 1'b0;
        err_next = 1'b0;
        next_state = state; // Default to hold current state

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
                else begin
                    next_state = IDLE;
                    disc_next = 1;   // Bit needs to be discarded (0111110 detected)
                end
            end
            SEVEN: begin
                if (in) begin
                    next_state = SEVEN;
                    err_next = 1;  // Error: 7 or more consecutive 1s detected
                end else begin
                    next_state = IDLE;
                    flag_next = 1; // End of frame detected (01111110 detected)
                end
            end
            default: 
                next_state = IDLE;
        endcase
    end
endmodule
