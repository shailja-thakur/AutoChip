module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, FOUND_1 = 2'b01, FOUND_10 = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == FOUND_10) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b1)
                next_state = FOUND_1;
            else
                next_state = IDLE;
        end
        FOUND_1: begin
            if (x == 1'b0)
                next_state = FOUND_10;
            else
                next_state = FOUND_1;
        end
        FOUND_10: begin
            if (x == 1'b1)
                next_state = FOUND_1;
            else
                next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
