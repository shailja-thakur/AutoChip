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

localparam IDLE = 3'b000;
localparam START_DETECT = 3'b001;
localparam SHIFT_DURATION = 3'b010;
localparam COUNTING = 3'b011;
localparam DONE = 3'b100;

reg [2:0] state, next_state;
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
                shift_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            START_DETECT: begin
                if (data == 1'b1) begin
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_count <= 0;
                end
                if (shift_count == 4) begin
                    shift_count <= 0;
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    next_state <= START_DETECT;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                shift_count <= shift_count + 1;
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    shift_count <= 0;
                    next_state <= COUNTING;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= DONE;
                end
                else begin
                    next_state <= COUNTING;
                end
            end
            DONE: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                end
                else begin
                    next_state <= DONE;
                end
            end
        endcase
    end
end

endmodule
