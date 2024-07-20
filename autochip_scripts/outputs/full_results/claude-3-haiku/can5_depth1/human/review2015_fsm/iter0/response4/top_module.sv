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

// State encoding
localparam [2:0] WAIT_START = 3'b000,
                SHIFT_BITS  = 3'b001,
                COUNTING    = 3'b010,
                DONE        = 3'b011;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_START: begin
                shift_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    if (shift_count == 4'b0000) next_state <= WAIT_START;
                    else if (shift_count == 4'b1100) next_state <= SHIFT_BITS;
                    else next_state <= WAIT_START;
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_count <= 0;
                    next_state <= WAIT_START;
                end
            end
            SHIFT_BITS: begin
                shift_ena <= 1;
                if (shift_count == 4'b0100) begin
                    shift_ena <= 0;
                    next_state <= COUNTING;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= shift_count + 1;
                    next_state <= SHIFT_BITS;
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
                    done <= 0;
                    next_state <= WAIT_START;
                end
                else begin
                    next_state <= DONE;
                end
            end
            default: next_state <= WAIT_START;
        endcase
    end
end

endmodule
