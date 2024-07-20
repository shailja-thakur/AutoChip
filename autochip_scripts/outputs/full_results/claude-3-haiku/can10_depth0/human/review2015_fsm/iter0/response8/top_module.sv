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

localparam [2:0] WAIT_FOR_START = 3'b000,
                 SHIFT_DATA     = 3'b001,
                 WAIT_DONE      = 3'b010,
                 NOTIFY_USER    = 3'b011;

reg [2:0] state, next_state;
reg [3:0] bit_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        bit_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_FOR_START: begin
                if (data == 1'b1) bit_count <= 1;
                else bit_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            SHIFT_DATA: begin
                if (bit_count == 4) begin
                    bit_count <= 0;
                    shift_ena <= 0;
                    next_state <= WAIT_DONE;
                end
                else begin
                    bit_count <= bit_count + 1;
                    shift_ena <= 1;
                end
                counting <= 0;
                done <= 0;
            end
            WAIT_DONE: begin
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                end
                else begin
                    counting <= 1;
                    shift_ena <= 0;
                    done <= 0;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    next_state <= WAIT_FOR_START;
                end
                else begin
                    done <= 1;
                    counting <= 0;
                    shift_ena <= 0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WAIT_FOR_START: begin
            if (bit_count == 4 && data == 1'b1) begin
                next_state = SHIFT_DATA;
            end
            else begin
                next_state = WAIT_FOR_START;
            end
        end
        SHIFT_DATA: begin
            next_state = SHIFT_DATA;
        end
        WAIT_DONE: begin
            next_state = WAIT_DONE;
        end
        NOTIFY_USER: begin
            next_state = NOTIFY_USER;
        end
        default: begin
            next_state = WAIT_FOR_START;
        end
    endcase
end

endmodule
