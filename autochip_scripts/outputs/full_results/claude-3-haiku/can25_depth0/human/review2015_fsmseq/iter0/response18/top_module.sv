module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'd0, FOUND1 = 2'd1, FOUND11 = 2'd2, FOUND110 = 2'd3;
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == FOUND110)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1)
                next_state = FOUND1;
            else
                next_state = IDLE;
        end
        FOUND1: begin
            if (data == 1)
                next_state = FOUND11;
            else
                next_state = IDLE;
        end
        FOUND11: begin
            if (data == 0)
                next_state = FOUND110;
            else
                next_state = IDLE;
        end
        FOUND110: begin
            next_state = FOUND110;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
