module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state, next_state;
    reg [2:0] bit_count;  // Counter to count shifted bits
    reg [15:0] cycle_count;  // Counter to count cycles for delay
    reg [3:0] delay;  // The 4-bit delay value

    localparam IDLE         = 4'd0,
               PATTERN_DET  = 4'd1,
               SHIFT_DELAY  = 4'd2,
               COUNT        = 4'd3,
               DONE_WAIT    = 4'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            cycle_count <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            count <= 4'dx;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    bit_count <= 0;
                    cycle_count <= 0;
                    counting <= 0;
                    done <= 0;
                    delay <= 0;
                    count <= 4'dx;
                end
                PATTERN_DET: begin
                    if (bit_count == 3) bit_count <= 0;
                    else bit_count <= bit_count + 1;
                end
                SHIFT_DELAY: begin
                    delay <= {delay[2:0], data};
                    if (bit_count == 2) bit_count <= 0;
                    else bit_count <= bit_count + 1;
                end
                COUNT: begin
                    if (cycle_count == 999) begin
                        cycle_count <= 0;
                        if (count == 0) count <= 4'dx;
                        else count <= count - 1;
                    end else begin
                        cycle_count <= cycle_count + 1;
                    end
                end
                DONE_WAIT: begin
                    if (ack) begin
                        bit_count <= 0;
                        cycle_count <= 0;
                        counting <= 0;
                        done <= 0;
                        delay <= 0;
                        count <= 4'dx;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                bit_count = 0;
                if (data == 1'b1) next_state = PATTERN_DET;
            end
            PATTERN_DET: begin
                if (bit_count == 3 && data == 1) next_state = SHIFT_DELAY;
                else if (bit_count == 3) next_state = IDLE;
            end
            SHIFT_DELAY: begin
                if (bit_count == 3) next_state = COUNT;
            end
            COUNT: begin
                counting = 1;
                if (count == 0 && cycle_count == 999) next_state = DONE_WAIT;
            end
            DONE_WAIT: begin
                counting = 0;
                done = 1;
                if (ack) next_state = IDLE;
            end
        endcase
    end
endmodule
