module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, DETECT1 = 2'b01, DETECT0 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE:
            if (x == 1'b1)
                next_state = DETECT1;
            else
                next_state = IDLE;
        DETECT1:
            if (x == 1'b0)
                next_state = DETECT0;
            else
                next_state = DETECT1;
        DETECT0:
            if (x == 1'b1)
                next_state = DETECT1;
            else
                next_state = IDLE;
        default:
            next_state = IDLE;
    endcase
end

always @(*) begin
    case (state)
        IDLE:
            z = 1'b0;
        DETECT1:
            z = 1'b0;
        DETECT0:
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
