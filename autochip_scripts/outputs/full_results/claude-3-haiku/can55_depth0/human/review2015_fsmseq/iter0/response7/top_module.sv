module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_INIT = 0;
localparam STATE_FIRST_1 = 1;
localparam STATE_FIRST_0 = 2;
localparam STATE_SECOND_1 = 3;
localparam STATE_FINAL = 4;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_INIT;
        start_shifting <= 0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_INIT: begin
            if (data == 1) next_state = STATE_FIRST_1;
            else next_state = STATE_INIT;
        end
        STATE_FIRST_1: begin
            if (data == 0) next_state = STATE_FIRST_0;
            else next_state = STATE_INIT;
        end
        STATE_FIRST_0: begin
            if (data == 1) next_state = STATE_SECOND_1;
            else next_state = STATE_INIT;
        end
        STATE_SECOND_1: begin
            if (data == 1) next_state = STATE_FINAL;
            else next_state = STATE_INIT;
        end
        STATE_FINAL: begin
            start_shifting = 1;
            next_state = STATE_FINAL;
        end
        default: next_state = STATE_INIT;
    endcase
end

endmodule
