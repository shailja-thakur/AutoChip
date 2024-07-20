module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter WAIT_0 = 2'b00, WAIT_1 = 2'b01, FOUND_101 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= WAIT_0;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        WAIT_0: begin
            if (x == 1'b0)
                next_state = WAIT_0;
            else
                next_state = WAIT_1;
        end
        WAIT_1: begin
            if (x == 1'b0)
                next_state = WAIT_0;
            else
                next_state = FOUND_101;
        end
        FOUND_101: begin
            z = 1'b1;
            if (x == 1'b0)
                next_state = WAIT_0;
            else
                next_state = WAIT_1;
        end
    endcase
end

endmodule
