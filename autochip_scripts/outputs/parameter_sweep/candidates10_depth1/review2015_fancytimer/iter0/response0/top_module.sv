module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    reg start_detected;
    reg [3:0] state;
    
    parameter IDLE = 0;
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_IN_DELAY = 2;
    parameter COUNT = 3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 0;
            counter <= 0;
            remaining_time <= 0;
            shift_reg <= 0;
            start_detected <= 0;
            state <= IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        start_detected <= 1;
                        state <= DETECT_PATTERN;
                    end
                end
                DETECT_PATTERN: begin
                    if (start_detected) begin
                        shift_reg <= {shift_reg[2:0], data};
                        state <= SHIFT_IN_DELAY;
                    end else begin
                        state <= IDLE;
                    end
                end
                SHIFT_IN_DELAY: begin
                    delay <= shift_reg;
                    counting <= 1;
                    state <= COUNT;
                end
                COUNT: begin
                    if (counter == ((delay + 1) * 1000 - 1)) begin
                        counter <= 0;
                        if (remaining_time > 0) begin
                            remaining_time <= remaining_time - 1;
                        end else begin
                            counting <= 0;
                            done <= 1;
                            state <= IDLE;
                        end
                    else begin
                        counter <= counter + 1;
                    end
                end
            endcase
        end
    end
    
    assign count = remaining_time;
    
    always @(negedge clk) begin
        if (reset || ack) begin
            remaining_time <= delay;
        end else if (counting) begin
            remaining_time <= remaining_time - 1;
        end
    end
endmodule
