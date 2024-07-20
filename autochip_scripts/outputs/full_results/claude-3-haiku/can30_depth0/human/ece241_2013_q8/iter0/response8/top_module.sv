module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_WAIT = 2'b00;
localparam STATE_DETECT_0 = 2'b01;
localparam STATE_DETECT_1 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= STATE_WAIT;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        STATE_WAIT: begin
            if (x == 1'b0)
                next_state = STATE_DETECT_0;
        end
        STATE_DETECT_0: begin
            if (x == 1'b1)
                next_state = STATE_DETECT_1;
            else
                next_state = STATE_WAIT;
        end
        STATE_DETECT_1: begin
            if (x == 1'b0)
                next_state = STATE_WAIT;
            else
                next_state = STATE_DETECT_1;
            z = 1'b1;
        end
        default: begin
            next_state = STATE_WAIT;
            z = 1'b0;
        end
    endcase
end

endmodule
