module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'd0, CONVERT = 2'd1, DONE = 2'd2;
reg [1:0] state, next_state;
reg [7:0] input_num, result;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 0;
        result <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_num <= {input_num[6:0], x};
        if (state == CONVERT) begin
            result <= result - 1;
        end
        if (state == DONE) begin
            z <= ~result + 1;
        end
        else begin
            z <= 0;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (x) ? CONVERT : IDLE;
        CONVERT: next_state = (input_num == 8'b11111111) ? DONE : CONVERT;
        DONE: next_state = (areset) ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule
