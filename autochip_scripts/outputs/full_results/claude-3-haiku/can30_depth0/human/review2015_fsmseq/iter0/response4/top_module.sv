module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_INIT = 0, STATE_S1 = 1, STATE_S2 = 2, STATE_S3 = 3, STATE_S4 = 4;
reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_INIT;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_INIT: begin
            if (data == 1'b1) begin
                next_state = STATE_S1;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_S1: begin
            if (data == 1'b1) begin
                next_state = STATE_S2;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_S2: begin
            if (data == 1'b0) begin
                next_state = STATE_S3;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_S3: begin
            if (data == 1'b1) begin
                next_state = STATE_S4;
            end
            else begin
                next_state = STATE_INIT;
            end
            start_shifting = 1'b0;
        end
        STATE_S4: begin
            next_state = STATE_INIT;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_INIT;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
