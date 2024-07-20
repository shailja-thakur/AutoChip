module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] num, neg_num;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        count <= 0;
        num <= 0;
        neg_num <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                count <= 0;
                num <= 0;
                neg_num <= 0;
                z <= 0;
            end
            COMPUTE: begin
                num <= {num[6:0], x};
                count <= count + 1;
                if (count == 7) begin
                    neg_num <= ~num + 1;
                    next_state <= DONE;
                end
            end
            DONE: begin
                z <= neg_num[count];
                if (count == 0) begin
                    next_state <= IDLE;
                end
                else begin
                    count <= count - 1;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = COMPUTE;
        COMPUTE: next_state = COMPUTE;
        DONE: next_state = DONE;
    endcase
end

endmodule
