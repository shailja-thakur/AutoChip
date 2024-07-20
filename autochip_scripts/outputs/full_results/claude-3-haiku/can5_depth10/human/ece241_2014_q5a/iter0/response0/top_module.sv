module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
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
        case (state)
            IDLE: begin
                sum <= 0;
                count <= 0;
                z <= 0;
            end
            CONVERT: begin
                sum <= sum + {7'b0, x};
                count <= count + 1;
                z <= ~sum[7];
            end
            DONE: begin
                z <= ~sum[7];
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
            if (count == 4'd8) begin
                next_state = DONE;
            end
            else begin
                next_state = CONVERT;
            end
        end
        DONE: begin
            if (areset) begin
                next_state = IDLE;
            end
            else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
