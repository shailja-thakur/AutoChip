module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] acc;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        acc <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                acc <= 0;
                z <= 0;
            end
            COMPUTE: begin
                acc <= {acc[6:0], x};
                z <= ~acc[7] & (acc != 0);
            end
            DONE: begin
                z <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = x ? COMPUTE : IDLE;
        COMPUTE: next_state = (acc == 8'b11111111) ? DONE : COMPUTE;
        DONE: next_state = areset ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule
