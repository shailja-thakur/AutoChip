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

// Define the necessary states
localparam STATE_SEARCH = 3'd0;
localparam STATE_SHIFT  = 3'd1;
localparam STATE_COUNT  = 3'd2;
localparam STATE_NOTIFY = 3'd3;
localparam STATE_ACK    = 3'd4;

reg [2:0] current_state, next_state;
reg [3:0] shift_count;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= STATE_SEARCH;
        shift_count <= 0;
    end
    else begin
        current_state <= next_state;
        if (current_state == STATE_SHIFT)
            shift_count <= shift_count + 1;
    end
end

// Next state logic
always @(*) begin
    next_state = current_state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (current_state)
        STATE_SEARCH: begin
            if (data == 1'b1) begin
                if ({data, data, data, data} == 4'b1101) begin
                    next_state = STATE_SHIFT;
                    shift_ena = 1;
                end
            end
        end
        STATE_SHIFT: begin
            shift_ena = 1;
            if (shift_count == 4) begin
                next_state = STATE_COUNT;
            end
        end
        STATE_COUNT: begin
            counting = 1;
            if (done_counting) begin
                next_state = STATE_NOTIFY;
            end
        end
        STATE_NOTIFY: begin
            done = 1;
            if (ack) begin
                next_state = STATE_SEARCH;
            end
        end
    endcase
end

endmodule
