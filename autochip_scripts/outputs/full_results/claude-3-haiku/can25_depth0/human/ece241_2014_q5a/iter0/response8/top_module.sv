module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] WAIT = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] sum;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAIT;
        sum <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT: begin
                sum <= 0;
                z <= 0;
            end
            COMPUTE: begin
                sum <= {sum[6:0], x};
                z <= ~sum[7] & (|sum[6:0]);
            end
            DONE: begin
                z <= ~sum[7];
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WAIT: next_state = x ? COMPUTE : WAIT;
        COMPUTE: next_state = (sum[7] | ~(|sum[6:0])) ? DONE : COMPUTE;
        DONE: next_state = WAIT;
        default: next_state = WAIT;
    endcase
end

endmodule
