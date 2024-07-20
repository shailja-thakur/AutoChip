module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10, STATE3 = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        IDLE: begin
            if (x == 1'b1) begin
                next_state = STATE1;
            end
        end
        STATE1: begin
            if (x == 1'b0) begin
                next_state = STATE2;
            end else begin
                next_state = IDLE;
            end
        end
        STATE2: begin
            if (x == 1'b1) begin
                next_state = STATE3;
                z = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end
        STATE3: begin
            if (x == 1'b0) begin
                next_state = IDLE;
            end else begin
                next_state = STATE1;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
