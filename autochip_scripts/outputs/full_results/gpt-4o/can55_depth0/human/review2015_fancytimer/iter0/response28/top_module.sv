module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] pattern_shift;
    reg [3:0] delay;
    reg [12:0] counter;
    reg [3:0] state;
    
    localparam  S_IDLE = 4'd0,
                S_SHIFT_PATTERN = 4'd1,
                S_SHIFT_DELAY = 4'd2,
                S_COUNT = 4'd3,
                S_DONE = 4'd4;

    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            pattern_shift <= 4'b0;
            delay <= 4'b0;
            counter <= 13'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                S_IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data) begin
                        pattern_shift <= {pattern_shift[2:0], data};
                        if (pattern_shift == 4'b1101 && data == 1'b1) begin
                            state <= S_SHIFT_DELAY;
                            count <= 4'b1111; // don't-care value
                        end
                    end
                end
                S_SHIFT_DELAY: begin
                    pattern_shift <= {pattern_shift[2:0], data};
                    delay <= {delay[2:0], data};
                    if (pattern_shift == 4'b1101) begin
                        delay <= {delay[2:0], data};
                        state <= S_COUNT;
                        counter <= delay * 1000 + 1;
                        count <= delay;
                    end
                end
                S_COUNT: begin
                    counting <= 1'b1;
                    counter <= counter - 1;
                    
                    if (counter % 1000 == 0) begin
                        count <= count - 1;
                    end
                    
                    if (counter == 0) begin
                        state <= S_DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                S_DONE: begin
                    counting <= 1'b0;
                    if (ack == 1'b1) begin
                        done <= 1'b0;
                        state <= S_IDLE;
                    end
                end
                default: state <= S_IDLE;
            endcase
        end
    end
endmodule
