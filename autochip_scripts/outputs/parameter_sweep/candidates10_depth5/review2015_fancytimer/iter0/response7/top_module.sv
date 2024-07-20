module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    // Internal signals
    reg [3:0] delay;
    reg [3:0] timer_count;
    reg [1:0] state;
    
    // State constants
    localparam IDLE = 2'b00;
    localparam DETECT_SEQ = 2'b01;
    localparam SHIFT_IN = 2'b10;
    localparam COUNT = 2'b11;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            delay <= 0;
            timer_count <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    // Wait for start sequence (1101)
                    if (data == 4'b1101) begin
                        state <= DETECT_SEQ;
                    end
                end
                
                DETECT_SEQ: begin
                    // Shift in the next 4 bits as delay
                    delay <= {data[3], data[2], data[1], data[0]};
                    state <= SHIFT_IN;
                end
                
                SHIFT_IN: begin
                    // Start counting and set counting signal
                    counting <= 1;
                    timer_count <= (delay + 1) * 1000;
                    state <= COUNT;
                end
                
                COUNT: begin
                    // Continue counting
                    if (timer_count > 0) begin
                        timer_count <= timer_count - 1;
                    end
                    else begin
                        // Finish counting, assert done signal
                        counting <= 0;
                        done <= 1;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
    
    // Output count
    assign count = counting ? timer_count / 1000 : 4'bxxxx;
    
    // Wait for acknowledge signal to reset
    always @(posedge clk) begin
        if (ack) begin
            done <= 0;
        end
    end
endmodule
