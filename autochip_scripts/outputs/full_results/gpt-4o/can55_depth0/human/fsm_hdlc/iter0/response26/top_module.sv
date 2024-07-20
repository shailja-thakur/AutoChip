module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);
    
    reg [2:0] state, next_state;

    // State encoding
    localparam STATE_0 = 3'd0,
               STATE_1 = 3'd1,
               STATE_2 = 3'd2,
               STATE_3 = 3'd3,
               STATE_4 = 3'd4,
               STATE_5 = 3'd5,
               STATE_6 = 3'd6,
               STATE_ERROR = 3'd7;
               

    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;
        case (state)
            STATE_0: begin
                if (in) next_state = STATE_1;
                else next_state = STATE_0;
            end
            STATE_1: begin
                if (in) next_state = STATE_2;
                else next_state = STATE_0;
            end
            STATE_2: begin
                if (in) next_state = STATE_3;
                else next_state = STATE_0;
            end
            STATE_3: begin
                if (in) next_state = STATE_4;
                else next_state = STATE_0;
            end
            STATE_4: begin
                if (in) next_state = STATE_5;
                else next_state = STATE_0;
            end
            STATE_5: begin
                if (in) next_state = STATE_6;
                else begin
                    next_state = STATE_0;
                    disc = 1; // 0111110 detected
                end
            end
            STATE_6: begin
                if (in) next_state = STATE_ERROR;
                else begin
                    next_state = STATE_0;
                    flag = 1; // 01111110 detected
                end
            end
            STATE_ERROR: begin
                if (in) begin
                    next_state = STATE_ERROR; // Stay in error state
                    err = 1; // 01111111... detected
                end else begin
                    next_state = STATE_0;
                end
            end
        endcase
    end
endmodule
