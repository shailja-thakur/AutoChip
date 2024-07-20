module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [1:0] IDLE  = 2'b00,
                FOUND1 = 2'b01,
                FOUND11 = 2'b10,
                FOUND110 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == FOUND110) begin
            start_shifting <= 1'b1;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = FOUND1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND1: begin
            if (data == 1'b1) begin
                next_state = FOUND11;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND11: begin
            if (data == 1'b0) begin
                next_state = FOUND110;
            end
            else begin
                next_state = IDLE;
            end
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
