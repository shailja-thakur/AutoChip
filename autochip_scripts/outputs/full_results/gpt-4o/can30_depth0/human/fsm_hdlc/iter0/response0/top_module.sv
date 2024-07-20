module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S_ONE = 3'd1,
        S_TWO = 3'd2,
        S_THREE = 3'd3,
        S_FOUR = 3'd4,
        S_FIVE = 3'd5,
        S_SIX = 3'd6,
        S_SEVEN = 3'd7
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    if (in) begin
                        next_state <= S_ONE;
                    end else begin
                        next_state <= S_IDLE;
                    end
                end
                S_ONE: begin
                    if (in) next_state <= S_TWO;
                    else    next_state <= S_IDLE;
                end
                S_TWO: begin
                    if (in) next_state <= S_THREE;
                    else    next_state <= S_IDLE;
                end
                S_THREE: begin
                    if (in) next_state <= S_FOUR;
                    else    next_state <= S_IDLE;
                end
                S_FOUR: begin
                    if (in) next_state <= S_FIVE;
                    else    next_state <= S_IDLE;
                end
                S_FIVE: begin
                    if (in) next_state <= S_SIX;
                    else    next_state <= S_IDLE;
                end
                S_SIX: begin
                    if (in) next_state <= S_SEVEN;
                    else begin
                        next_state <= S_IDLE;
                        disc <= 1'b1;
                    end
                end
                S_SEVEN: begin
                    if (in) begin
                        next_state <= S_SEVEN;
                        err <= 1'b1;
                    end else begin
                        next_state <= S_IDLE;
                        flag <= 1'b1;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (~reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end
    end
endmodule
