module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, FIRST_1 = 2'b01, DETECTED = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == DETECTED) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x == 1'b1) ? FIRST_1 : IDLE;
        end
        FIRST_1: begin
            next_state = (x == 1'b0) ? IDLE : (x == 1'b1) ? FIRST_1 : DETECTED;
        end
        DETECTED: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
