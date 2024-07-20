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
        sum <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                sum <= 0;
                z <= 0;
            end
            COMP: begin
                sum <= sum - x;
                z <= 0;
            end
            DONE: begin
                sum <= 0;
                z <= ~sum + 1;
            end
        endcase
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
