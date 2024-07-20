module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] STATE_IDLE = 2'b00,
                 STATE_ONE  = 2'b01,
                 STATE_END  = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        STATE_IDLE: begin
            if (x == 1'b1) begin
                next_state = STATE_ONE;
            end
        end
        STATE_ONE: begin
            if (x == 1'b0) begin
                next_state = STATE_END;
            end else begin
                next_state = STATE_ONE;
            end
        end
        STATE_END: begin
            if (x == 1'b1) begin
                z = 1'b1;
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
