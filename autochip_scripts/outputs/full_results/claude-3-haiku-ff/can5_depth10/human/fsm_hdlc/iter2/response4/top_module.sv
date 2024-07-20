module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State definitions
    localparam STATE_IDLE = 3'd0;
    localparam STATE_ONE = 3'd1;
    localparam STATE_TWO = 3'd2;
    localparam STATE_THREE = 3'd3;
    localparam STATE_FOUR = 3'd4;
    localparam STATE_FIVE = 3'd5;
    localparam STATE_SIX = 3'd6;
    localparam STATE_SEVEN = 3'd7;

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        // Next state logic
        case (state)
            STATE_IDLE: begin
                if (in == 1'b1) begin
                    next_state = STATE_ONE;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_ONE: begin
                if (in == 1'b1) begin
                    next_state = STATE_TWO;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_TWO: begin
                if (in == 1'b1) begin
                    next_state = STATE_THREE;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_THREE: begin
                if (in == 1'b1) begin
                    next_state = STATE_FOUR;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_FOUR: begin
                if (in == 1'b1) begin
                    next_state = STATE_FIVE;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_FIVE: begin
                if (in == 1'b0) begin
                    next_state = STATE_IDLE;
                    disc = 1'b1;
                end
                else begin
                    next_state = STATE_SIX;
                end
            end
            STATE_SIX: begin
                if (in == 1'b1) begin
                    next_state = STATE_SEVEN;
                    flag = 1'b1;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_SEVEN: begin
                if (in == 1'b1) begin
                    next_state = STATE_SEVEN;
                    err = 1'b1;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

endmodule
