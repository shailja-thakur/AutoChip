module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'd0, WAIT_1 = 2'd1, WAIT_0 = 2'd2;
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == WAIT_0 && x == 1'b1);
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b1)
                next_state = WAIT_1;
            else
                next_state = IDLE;
        end
        WAIT_1: begin
            if (x == 1'b0)
                next_state = WAIT_0;
            else
                next_state = WAIT_1;
        end
        WAIT_0: begin
            if (x == 1'b1)
                next_state = WAIT_1;
            else
                next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
