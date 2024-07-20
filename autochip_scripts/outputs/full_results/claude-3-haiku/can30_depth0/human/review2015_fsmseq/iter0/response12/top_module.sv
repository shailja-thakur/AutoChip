module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00, // Initial state
                 FIRST_ONE = 2'b01,
                 SECOND_ZERO = 2'b10,
                 THIRD_ONE = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = FIRST_ONE;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 1'b0;
        end
        FIRST_ONE: begin
            if (data == 1'b0) begin
                next_state = SECOND_ZERO;
            end
            else begin
                next_state = FIRST_ONE;
            end
            start_shifting = 1'b0;
        end
        SECOND_ZERO: begin
            if (data == 1'b1) begin
                next_state = THIRD_ONE;
            end
            else begin
                next_state = SECOND_ZERO;
            end
            start_shifting = 1'b0;
        end
        THIRD_ONE: begin
            if (data == 1'b1) begin
                next_state = FIRST_ONE;
            end
            else begin
                next_state = IDLE;
            end
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
