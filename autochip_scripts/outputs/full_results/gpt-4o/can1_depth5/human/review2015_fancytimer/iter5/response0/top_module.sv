module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] bit_count;
    reg [3:0] delay;
    reg [3:0] countdown;
    reg [9:0] cycle_count;
    reg [2:0] state, next_state;

    localparam IDLE = 3'd0,
               READ_DELAY = 3'd1,
               COUNT = 3'd2,
               WAIT_ACK = 3'd3,
               FINISHED = 3'd4;

    // FSM state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            cycle_count <= 0;
            countdown <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                IDLE: begin
                    bit_count <= 0;
                    if (bit_count == 4'b1101) begin
                        bit_count <= 0;
                    end else begin
                        bit_count <= {bit_count[2:0], data};
                    end
                end
                READ_DELAY: begin
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};
                        bit_count <= bit_count + 1;
                    end
                end
                COUNT: begin
                    if (cycle_count == 10'd999) begin
                        cycle_count <= 0;
                        if (countdown != 0) begin
                            countdown <= countdown - 1;
                        end
                    end else begin
                        cycle_count <= cycle_count + 1;
                    end
                end
                FINISHED: begin
                    done <= 1;
                    counting <= 0;
                end
                default: ;
            endcase
        end
    end

    // FSM next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (bit_count == 4'b1101) begin
                    next_state = READ_DELAY;
                end
            end

            READ_DELAY: begin
                if (bit_count == 4) begin
                    next_state = COUNT;
                    counting <= 1;
                    countdown <= delay;
                end
            end

            COUNT: begin
                if (cycle_count == 10'd999 && countdown == 0) begin
                    next_state = FINISHED;
                end
            end

            FINISHED: begin
                if (ack) begin
                    next_state = IDLE;
                    done <= 0;
                end
            end

            default: next_state = IDLE;
        endcase
    end

    // Control the counting and done signals
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
        end else begin
            if (state == COUNT) begin
                counting <= 1;
                done <= 0;
            end else if (state == FINISHED) begin
                counting <= 0;
                done <= 1;
            end
        end
    end

    // Generate cycle_count to handle 1000 clock cycles
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 0;
        end else if (state == COUNT) begin
            if (cycle_count == 10'd999) begin
                cycle_count <= 0;
            end else begin
                cycle_count <= cycle_count + 1;
            end
        end else begin
            cycle_count <= 0;
        end
    end

    // Generate the count output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
        end else if (state == COUNT) begin
            count <= countdown;
        end else begin
            count <= 4'b0;
        end
    end

endmodule
