module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [2:0] state, next_state;
    reg [3:0] shift_reg;
    reg [9:0] cycle_counter;
    reg [3:0] delay;
    reg [2:0] bit_count;

    localparam STATE_WAIT_PATTERN   = 3'd0,
               STATE_SHIFT_DELAY    = 3'd1,
               STATE_LOAD_DELAY     = 3'd2,
               STATE_COUNT          = 3'd3,
               STATE_WAIT_ACK       = 3'd4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_WAIT_PATTERN;
            shift_reg <= 4'd0;
            delay <= 4'd0;
            cycle_counter <= 10'd0;
            bit_count <= 3'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                STATE_WAIT_PATTERN: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101)
                        next_state <= STATE_SHIFT_DELAY;
                    else
                        next_state <= STATE_WAIT_PATTERN;
                end
                
                STATE_SHIFT_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data};
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd3) begin
                        next_state <= STATE_LOAD_DELAY;
                        delay <= {shift_reg[2:0], data};
                    end else begin
                        next_state <= STATE_SHIFT_DELAY;
                    end
                end

                STATE_LOAD_DELAY: begin
                    counting <= 1'b1;
                    cycle_counter <= 10'd0;
                    count <= delay;
                    next_state <= STATE_COUNT;
                end

                STATE_COUNT: begin
                    if (cycle_counter == 10'd999) begin
                        cycle_counter <= 10'd0;
                        if (count == 4'd0) begin
                            next_state <= STATE_WAIT_ACK;
                            counting <= 1'b0;
                            done <= 1'b1;
                        end else begin
                            count <= count - 1;
                        end
                    end else begin
                        cycle_counter <= cycle_counter + 1;
                    end
                    next_state <= STATE_COUNT;
                end

                STATE_WAIT_ACK: begin
                    if (ack) begin
                        done <= 1'b0;
                        next_state <= STATE_WAIT_PATTERN;
                    end else begin
                        next_state <= STATE_WAIT_ACK;
                    end
                end

                default: begin
                    next_state <= STATE_WAIT_PATTERN;
                end
            endcase
        end
    end

endmodule
