module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state;
    reg [3:0] delay;
    reg [3:0] bit_count;
    reg [9:0] cycle_count;
    
    // State encoding
    localparam IDLE = 4'd0,
               PATTERN_DETECT = 4'd1,
               LOAD_DELAY = 4'd2,
               COUNTING = 4'd3,
               DONE = 4'd4;

    // Pattern 1101 detector
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            count <= 4'dx;
            cycle_count <= 10'd0;
            delay <= 4'd0;
            bit_count <= 4'd0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    count <= 4'dx;
                    bit_count <= 4'd0;
                    cycle_count <= 10'd0;
                    state <= PATTERN_DETECT;
                end

                PATTERN_DETECT: begin
                    if (bit_count < 4) begin
                        bit_count <= bit_count + 1;
                        if ({bit_count, data} == 4'b1101) begin
                            state <= LOAD_DELAY;
                            bit_count <= 0;
                        end
                    end
                end

                LOAD_DELAY: begin
                    if (bit_count < 4) begin
                        delay <= {delay[2:0], data};
                        bit_count <= bit_count + 1;
                    end else begin
                        state <= COUNTING;
                        counting <= 1;
                        count <= delay;
                    end
                end

                COUNTING: begin
                    if (cycle_count < 999) begin
                        cycle_count <= cycle_count + 1;
                    end else begin
                        cycle_count <= 0;
                        if (count > 0) begin
                            count <= count - 1;
                        end else begin
                            state <= DONE;
                            counting <= 0;
                            done <= 1;
                        end
                    end
                end

                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
