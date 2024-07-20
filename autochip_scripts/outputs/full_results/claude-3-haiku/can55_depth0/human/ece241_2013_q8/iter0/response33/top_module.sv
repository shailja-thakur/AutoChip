module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_IDLE = 2'b00;
localparam STATE_ONE  = 2'b01;
localparam STATE_DONE = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (x) begin
                next_state = STATE_ONE;
            end
            else begin
                next_state = STATE_IDLE;
            end
            z = 1'b0;
        end
        STATE_ONE: begin
            if (x) begin
                next_state = STATE_DONE;
            end
            else begin
                next_state = STATE_IDLE;
            end
            z = 1'b0;
        end
        STATE_DONE: begin
            if (x) begin
                next_state = STATE_ONE;
            end
            else begin
                next_state = STATE_IDLE;
            end
            z = 1'b1;
        end
        default: begin
            next_state = STATE_IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
