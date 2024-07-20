module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    IDLE = 2'd0,
    COMPUTE = 2'd1,
    DONE = 2'd2;

reg [1:0] state, next_state;
reg [7:0] sum;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        sum <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        sum <= (state == COMPUTE) ? sum + {7'b0, ~x} + 1 : sum;
        count <= (state == COMPUTE) ? count + 1 : count;
        z <= (state == DONE) ? ~sum[7:0] : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (areset) ? IDLE : COMPUTE;
        COMPUTE: next_state = (count == 4'd8) ? DONE : COMPUTE;
        DONE: next_state = (areset) ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule
