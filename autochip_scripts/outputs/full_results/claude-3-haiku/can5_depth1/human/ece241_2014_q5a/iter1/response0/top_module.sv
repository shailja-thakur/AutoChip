module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'd0, CONVERT = 2'd1, DONE = 2'd2;
reg [1:0] state, next_state;
reg [7:0] input_num, result;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 8'b0;
        result <= 8'b0;
        z <= 1'b0;
        count <= 4'b0;
    end
    else begin
        state <= next_state;
        input_num <= {input_num[6:0], x};
        result <= (state == CONVERT) ? result - 1 : result;
        z <= (state == DONE) ? ~result[7:0] + 1 : 1'b0;
        count <= (state == CONVERT) ? count + 1 : count;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (x) ? CONVERT : IDLE;
        CONVERT: next_state = (count == 4'd8) ? DONE : CONVERT;
        DONE: next_state = (areset) ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule
