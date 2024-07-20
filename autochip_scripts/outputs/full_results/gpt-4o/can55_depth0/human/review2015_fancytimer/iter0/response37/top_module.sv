module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum reg [2:0] {
        IDLE      = 3'd0,
        DETECT    = 3'd1,
        LOAD      = 3'd2,
        COUNT     = 3'd3,
        WAIT_ACK  = 3'd4
    } state_t;

    reg [2:0] state, next_state;
    reg [3:0] pattern_shift_reg;
    reg [3:0] delay;
    reg [15:0] cycle_count;
    reg [2:0] bit_count;
    reg [3:0] `current_delay;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            pattern_shift_reg <= 4'b0000;
            delay <= 4'b0000;
            bit_count <= 3'd0;
            cycle_count <= 16'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (bit_count == 3'd3) begin
                        pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                        if (pattern_shift_reg == 4'b1101) begin
                            next_state <= LOAD;
                            bit_count <= 3'd0;
                        end else begin
                            bit_count <= bit_count + 3'd1;
                        end
                    end else begin
                        pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                        bit_count <= bit_count + 3'd1;
                    end
                end

                LOAD: begin
                    if (bit_count == 3'd3) begin
                        delay <= {delay[2:0], data};
                        bit_count <= 3'd0;
                        next_state <= COUNT;
                        cycle_count <= (delay + 4'b0001) * 16'd1000;
                    end else begin
                        delay <= {delay[2:0], data};
                        bit_count <= bit_count + 3'd1;
                    end
                end

                COUNT: begin
                    counting <= 1'b1;
                    `current_delay <= cycle_count / 1000;
                    if (cycle_count == 16'b0) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        next_state <= WAIT_ACK;
                    end else begin
                        cycle_count <= cycle_count - 16'b1;
                    end
                end

                WAIT_ACK: begin
                    if (ack == 1'b1) begin
                        done <= 1'b0;
                        next_state <= IDLE;
                    end
                end

                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end
endmodule
