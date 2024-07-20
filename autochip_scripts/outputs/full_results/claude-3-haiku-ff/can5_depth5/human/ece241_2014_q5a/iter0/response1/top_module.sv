module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] acc, next_acc;

always @(*) begin
    next_state = state;
    next_acc = acc;
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
                next_acc = 0;
            end
        end
        CONVERT: begin
            next_acc = {acc[6:0], x};
            if (areset) begin
                next_state = DONE;
                z = ~acc + 1;
            end
        end
        DONE: begin
            z = 0;
            if (~areset) begin
                next_state = IDLE;
            end
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        acc <= 0;
    end
    else begin
        state <= next_state;
        acc <= next_acc;
    end
end

endmodule
