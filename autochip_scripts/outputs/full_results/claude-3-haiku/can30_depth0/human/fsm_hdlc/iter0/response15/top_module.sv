module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    localparam STATE_ZERO = 3'b000;
    localparam STATE_ONE  = 3'b001;
    localparam STATE_TWO  = 3'b010;
    localparam STATE_THREE = 3'b011;
    localparam STATE_FOUR = 3'b100;
    localparam STATE_FIVE = 3'b101;
    localparam STATE_SIX  = 3'b110;
    localparam STATE_SEVEN = 3'b111;

    reg [2:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_ZERO;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end
        else begin
            current_state <= next_state;
            case (current_state)
                STATE_ZERO: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                STATE_ONE: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                STATE_TWO: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                STATE_THREE: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                STATE_FOUR: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                STATE_FIVE: begin
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                STATE_SIX: begin
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                STATE_SEVEN: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
            endcase
        end
    end

    always @(*) begin
        case (current_state)
            STATE_ZERO: next_state = in ? STATE_ONE : STATE_ZERO;
            STATE_ONE: next_state = in ? STATE_TWO : STATE_ZERO;
            STATE_TWO: next_state = in ? STATE_THREE : STATE_ZERO;
            STATE_THREE: next_state = in ? STATE_FOUR : STATE_ZERO;
            STATE_FOUR: next_state = in ? STATE_FIVE : STATE_ZERO;
            STATE_FIVE: next_state = in ? STATE_SIX : STATE_ZERO;
            STATE_SIX: next_state = in ? STATE_SEVEN : STATE_ZERO;
            STATE_SEVEN: next_state = in ? STATE_SEVEN : STATE_ZERO;
        endcase
    end

endmodule
