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

reg [1:0] state;
reg [3:0] bit_count;

localparam [1:0] 
    IDLE = 2'b00,
    DETECT_PATTERN = 2'b01,
    COUNT_DURATION = 2'b10,
    NOTIFY_USER = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        bit_count <= 4'b0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                bit_count <= 4'b0;
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
            end
            DETECT_PATTERN: begin
                bit_count <= bit_count + 1'b1;
                if (bit_count == 4'd4 && data == 1'b1) begin
                    state <= COUNT_DURATION;
                    shift_ena <= 1'b1;
                end
                else if (bit_count == 4'd4) begin
                    state <= IDLE;
                end
            end
            COUNT_DURATION: begin
                shift_ena <= 1'b1;
                bit_count <= bit_count + 1'b1;
                if (bit_count == 4'd8) begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                    state <= NOTIFY_USER;
                end
            end
            NOTIFY_USER: begin
                counting <= 1'b0;
                done <= 1'b1;
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
