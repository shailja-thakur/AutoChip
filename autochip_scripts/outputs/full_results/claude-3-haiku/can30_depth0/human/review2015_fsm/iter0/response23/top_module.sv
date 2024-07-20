module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

localparam [1:0] IDLE = 2'b00, START = 2'b01, SHIFT = 2'b10, WAIT = 2'b11;
reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    next_state <= START;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START: begin
                if (data == 1'b1) begin
                    next_state <= START;
                end
                else if (data == 1'b0) begin
                    shift_count <= 0;
                    next_state <= SHIFT;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SHIFT: begin
                shift_ena <= 1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    counting <= 1;
                    next_state <= WAIT;
                end
                else begin
                    shift_count <= shift_count + 1;
                    next_state <= SHIFT;
                end
            end
            WAIT: begin
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= WAIT;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
