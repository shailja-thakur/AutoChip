module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, FIRST_1 = 2'b01, SECOND_0 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            z = 0;
            if (x == 1)
                next_state = FIRST_1;
            else
                next_state = IDLE;
        end
        FIRST_1: begin
            z = 0;
            if (x == 0)
                next_state = SECOND_0;
            else
                next_state = FIRST_1;
        end
        SECOND_0: begin
            if (x == 1)
                next_state = FIRST_1;
            else
                next_state = SECOND_0;
            z = 1;
        end
        default: begin
            z = 0;
            next_state = IDLE;
        end
    endcase
end

endmodule
