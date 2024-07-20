module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum reg [2:0] {
        STATE_IDLE = 3'b000,
        STATE_DETECT = 3'b001,
        STATE_SHIFT = 3'b010,
        STATE_COUNT = 3'b011,
        STATE_DONE = 3'b100
    } state_t;
    
    reg [3:0] delay;
    reg [3:0] bit_count;
    reg [9:0] cycle_count_down;
    state_t state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= STATE_IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            delay <= 4'b0;
            bit_count <= 4'b0;
            cycle_count_down <= 10'd0;
        end else begin
            state <= next_state;

            // State transitions and outputs
            case (state)
                STATE_IDLE: begin
                    count <= 4'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    cycle_count_down <= 10'd0;
                    if (~reset) begin
                        next_state <= STATE_DETECT;
                    end
                end
                
                STATE_DETECT: begin
                    if (data == 1'b1) begin
                        bit_count <= 4'b1001;
                        next_state <= STATE_SHIFT;
                    end else begin
                        // Continue searching
                        next_state <= STATE_DETECT;
                    end
                end
                
                STATE_SHIFT: begin
                    bit_count <= bit_count - 1'b1;
                    delay <= {delay[2:0], data};
                    if (bit_count == 4'b0001) begin
                        counting <= 1'b1;
                        count <= {delay[2:0], data};
                        cycle_count_down <= (({delay[2:0], data} + 4'b1) * 4'd10) - 1'b1;
                        next_state <= STATE_COUNT;
                    end else begin
                        next_state <= STATE_SHIFT;
                    end
                end
                
                STATE_COUNT: begin
                    if (cycle_count_down == 10'd0) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        next_state <= STATE_DONE;
                    end else begin
                        if (cycle_count_down % 10'd1000 == 0)
                            count <= count - 1'b1;
                        cycle_count_down <= cycle_count_down - 1'b1;
                        next_state <= STATE_COUNT;
                    end
                end
                
                STATE_DONE: begin
                    if (ack) begin
                        next_state <= STATE_IDLE;
                    end else begin
                        next_state <= STATE_DONE;
                    end
                end

                default: next_state <= STATE_IDLE;
            endcase
        end
    end
endmodule
