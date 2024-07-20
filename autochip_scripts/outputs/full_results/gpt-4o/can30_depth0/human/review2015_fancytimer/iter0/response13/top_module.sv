module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] pattern_reg;
    reg [2:0] state;
    reg [12:0] counter;
    reg [3:0] delay;

    // State Definitions
    localparam IDLE = 3'd0,
               PATTERN_DETECT = 3'd1,
               SHIFT_DELAY = 3'd2,
               COUNTDOWN = 3'd3,
               DONE = 3'd4;

    // Synchronous process for state transitions and operations 
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern_reg <= 4'd0;
            delay <= 4'd0;
            counter <= 13'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
        end 
        else begin
            case (state)
                IDLE: begin
                    pattern_reg <= 4'd0;
                    delay <= 4'd0;
                    counter <= 13'd0;
                    counting <= 1'b0;
                    done <= 1'b0;
                    if (data) 
                        pattern_reg <= {pattern_reg[2:0], data};
                    
                    if (pattern_reg == 4'b1101) begin
                        state <= PATTERN_DETECT;
                    end
                end

                PATTERN_DETECT: begin
                    if (data) 
                        delay <= {delay[2:0], data};
                    
                    if (delay[3]) begin
                        state <= SHIFT_DELAY;
                        count <= delay;
                        counting <= 1'b1;
                        counter <= (delay + 1) * 1000;
                    end
                end

                SHIFT_DELAY: begin
                    counter <= counter - 1;
                    if (counter % 1000 == 0) count <= count - 1;
                    if (counter == 0) begin
                        state <= DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end

                DONE: begin
                    if (ack == 1) begin
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end    
endmodule
