module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10, STATE3 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == STATE3 && x == 1'b1)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b1)
                next_state = STATE1;
            else
                next_state = IDLE;
        end
        STATE1: begin
            if (x == 1'b0)
                next_state = STATE2;
            else
                next_state = IDLE;
        end
        STATE2: begin
            if (x == 1'b1)
                next_state = STATE3;
            else
                next_state = IDLE;
        end
        STATE3: begin
            if (x == 1'b0)
                next_state = IDLE;
            else
                next_state = STATE1;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
