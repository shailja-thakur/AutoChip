module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00,
                 CONVERT = 2'b01,
                 DONE = 2'b10;

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
            CONVERT: begin
                sum <= {sum[6:0], x};
                z <= ~sum[7];
            end
            DONE: begin
                z <= ~sum;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = CONVERT;
            end
            else begin
                next_state = IDLE;
            end
        end
        CONVERT: begin
            if (areset) begin
                next_state = IDLE;
            end
            else begin
                next_state = DONE;
            end
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
