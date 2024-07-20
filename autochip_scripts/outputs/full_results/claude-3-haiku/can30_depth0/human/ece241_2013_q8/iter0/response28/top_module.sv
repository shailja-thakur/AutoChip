module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] 
    STATE_INIT = 2'b00,
    STATE_1 = 2'b01,
    STATE_10 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= STATE_INIT;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        STATE_INIT: begin
            if (x == 1'b1) begin
                next_state = STATE_1;
            end
        end
        STATE_1: begin
            if (x == 1'b0) begin
                next_state = STATE_10;
            end else begin
                next_state = STATE_1;
            end
        end
        STATE_10: begin
            if (x == 1'b1) begin
                next_state = STATE_1;
                z = 1'b1;
            end else begin
                next_state = STATE_INIT;
            end
        end
        default: begin
            next_state = STATE_INIT;
        end
    endcase
end

endmodule
