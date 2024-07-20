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

    // Define the states
    localparam [2:0] 
        STATE_WAIT_START = 3'd0,
        STATE_SHIFT_DURATION = 3'd1,
        STATE_WAIT_DONE = 3'd2,
        STATE_NOTIFY_USER = 3'd3;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_WAIT_START;
            bit_count <= 4'd0;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                STATE_WAIT_START: begin
                    // Look for the start sequence 1101
                    if (data == 1'b1 && bit_count == 4'd0) bit_count <= 4'd1;
                    else if (data == 1'b1 && bit_count == 4'd1) bit_count <= 4'd2;
                    else if (data == 1'b0 && bit_count == 4'd2) bit_count <= 4'd3;
                    else if (data == 1'b1 && bit_count == 4'd3) begin
                        bit_count <= 4'd0;
                        next_state <= STATE_SHIFT_DURATION;
                    end
                    else bit_count <= 4'd0;
                end
                STATE_SHIFT_DURATION: begin
                    shift_ena <= 1'b1;
                    if (bit_count == 4'd4) begin
                        shift_ena <= 1'b0;
                        next_state <= STATE_WAIT_DONE;
                    end
                    bit_count <= bit_count + 4'd1;
                end
                STATE_WAIT_DONE: begin
                    counting <= 1'b1;
                    if (done_counting) begin
                        counting <= 1'b0;
                        next_state <= STATE_NOTIFY_USER;
                    end
                end
                STATE_NOTIFY_USER: begin
                    done <= 1'b1;
                    if (ack) begin
                        done <= 1'b0;
                        next_state <= STATE_WAIT_START;
                    end
                end
                default: next_state <= STATE_WAIT_START;
            endcase
        end
    end

endmodule
