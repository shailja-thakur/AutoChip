module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    // Internal signals and registers
    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining;
    reg [3:0] state;
    reg [3:0] next_state;
    
    // Constants
    localparam START_SEQ = 4'b1101;
    localparam COUNT_DURATION = 1000;
    localparam MAX_DELAY = 15;
    
    // State definitions
    localparam IDLE = 4'b0000;
    localparam DETECT_START_SEQ = 4'b0001;
    localparam SHIFT_IN_DELAY = 4'b0010;
    localparam COUNT = 4'b0011;
    localparam TIMER_DONE = 4'b0100;
    
    // Sequential logic process
    always @(posedge clk) begin
        if (reset) begin
            // Reset all registers and flags
            delay <= 0;
            counter <= 0;
            remaining <= 0;
            state <= IDLE;
            counting <= 0;
            done <= 0;
        end else begin
            // Update current state
            state <= next_state;
            
            // State transitions
            case (state)
                IDLE:
                    if (data == START_SEQ) begin
                        next_state <= DETECT_START_SEQ;
                        counting <= 1;
                    end else begin
                        next_state <= IDLE;
                        counting <= 0;
                    end
                DETECT_START_SEQ:
                    next_state <= SHIFT_IN_DELAY;
                    counting <= 0;
                    delay <= data[3:0];
                SHIFT_IN_DELAY:
                    next_state <= COUNT;
                    counting <= 0;
                COUNT:
                    if (counter < (delay + 1)) begin
                        next_state <= COUNT;
                        counter <= counter + 1;
                        counting <= 1;
                    end else begin
                        next_state <= TIMER_DONE;
                        counter <= 0;
                        counting <= 0;
                    end
                TIMER_DONE:
                    if (ack) begin
                        next_state <= IDLE;
                        done <= 0;
                        counting <= 0;
                    end else begin
                        next_state <= TIMER_DONE;
                        done <= 1;
                        counting <= 0;
                    end
            endcase
        end
    end
    
    // Combinational logic process
    always @(state, counter) begin
        case (state)
            IDLE:
                count = 4'bzzzz;
                remaining = 0;
            DETECT_START_SEQ:
                count = 4'bzzzz;
                remaining = 0;
            SHIFT_IN_DELAY:
                count = 4'bzzzz;
                remaining = 0;
            COUNT:
                count = counter;
                remaining = delay - counter;
            TIMER_DONE:
                count = 4'bzzzz;
                remaining = 0;
        endcase
    end
endmodule
