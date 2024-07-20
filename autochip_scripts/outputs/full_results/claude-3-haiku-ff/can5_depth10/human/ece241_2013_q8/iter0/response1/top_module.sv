module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_IDLE = 2'd0;
localparam STATE_ONE = 2'd1;
localparam STATE_ZERO = 2'd2;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: begin
            z = 0;
            if (x == 1) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_ONE: begin
            z = 0;
            if (x == 0) begin
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_ONE;
            end
        end
        STATE_ZERO: begin
            if (x == 1) begin
                z = 1;
                next_state = STATE_ONE;
            end else begin
                z = 0;
                next_state = STATE_IDLE;
            end
        end
        default: begin
            z = 0;
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
