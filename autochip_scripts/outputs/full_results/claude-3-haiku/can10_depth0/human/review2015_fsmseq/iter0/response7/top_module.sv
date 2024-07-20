module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [2:0] IDLE = 3'b000,
                FOUND_1 = 3'b001,
                FOUND_10 = 3'b010,
                FOUND_101 = 3'b011,
                FOUND_1101 = 3'b100;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 1'b0;
        end
        FOUND_1: begin
            if (data == 1'b0) begin
                next_state = FOUND_10;
            end
            else begin
                next_state = FOUND_1;
            end
            start_shifting = 1'b0;
        end
        FOUND_10: begin
            if (data == 1'b1) begin
                next_state = FOUND_101;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 1'b0;
        end
        FOUND_101: begin
            if (data == 1'b0) begin
                next_state = FOUND_1101;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 1'b0;
        end
        FOUND_1101: begin
            next_state = FOUND_1101;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
