module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMP = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        sum <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: sum <= 8'b0;
            COMP: sum <= {1'b0, sum[7:1]} - x;
            DONE: sum <= 8'b0;
        endcase
        z <= (state == DONE) ? ~sum + 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = x ? COMP : IDLE;
        COMP: next_state = x ? COMP : DONE;
        DONE: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
