module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam STATE_IDLE = 3'b000;
localparam STATE_FOUND_1 = 3'b001;
localparam STATE_FOUND_11 = 3'b010;
localparam STATE_FOUND_110 = 3'b011;
localparam STATE_FOUND_1101 = 3'b100;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_1;
            end
            else begin
                next_state = STATE_IDLE;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_1: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_11;
            end
            else begin
                next_state = STATE_IDLE;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_11: begin
            if (data == 1'b0) begin
                next_state = STATE_FOUND_110;
            end
            else begin
                next_state = STATE_IDLE;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_110: begin
            if (data == 1'b1) begin
                next_state = STATE_FOUND_1101;
            end
            else begin
                next_state = STATE_IDLE;
            end
            start_shifting = 1'b0;
        end
        STATE_FOUND_1101: begin
            next_state = STATE_FOUND_1101;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = STATE_IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
