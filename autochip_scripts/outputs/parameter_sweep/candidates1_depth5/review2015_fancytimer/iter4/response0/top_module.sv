module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Parameters
    parameter COUNT_DONE = 1000; // Number of clock cycles for each count
    
    // Internal signals
    reg [3:0] delay; // Duration of the timer delay
    reg [12:0] counter; // Counter for counting the clock cycles
    reg [3:0] remaining_time; // Remaining time for the timer delay
    reg [2:0] state; // State register
    
    // State definitions
    localparam IDLE = 3'b000;
    localparam DETECT_PATTERN = 3'b001;
    localparam SHIFT_IN_DELAY = 3'b010;
    localparam COUNT = 3'b011;
    localparam WAIT_FOR_USER = 3'b100;
    
    // Detect start pattern
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE; // Reset state machine
            counting <= 1'b0; // Reset counting signal
            done <= 1'b0; // Reset done signal
        end else begin
            case(state)
                IDLE: begin
                		if (data == 4'b1101) begin
                			state <= DETECT_PATTERN;
                		end
                    counting <= 1'b0;
                    done <= 1'b0;
                end

                DETECT_PATTERN: begin
                    state <= SHIFT_IN_DELAY;
                		counting <= 1'b0;
                    done <= 1'b0;
                end

                SHIFT_IN_DELAY: begin
                    state <= COUNT;
                		counting <= 1'b0;
                    done <= 1'b0;
                end

                COUNT: begin
                    counting <= 1'b1;
                    counter <= counter + 1;
                    if (counter == (delay + 1) * COUNT_DONE) begin
                        state <= WAIT_FOR_USER;
                    end
                end

                WAIT_FOR_USER: begin
                    counting <= 1'b0;
                    if (ack) begin
                        state <= IDLE;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end
    
    // Shift in delay bits
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0; // Reset delay
        end else begin
            case(state)
                SHIFT_IN_DELAY: begin
                    delay <= {data, delay[3:1]}; // Shift in next bit
                end
            endcase
        end
    end
    
    // Count clock cycles
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 13'b0; // Reset counter
            remaining_time <= 4'b0; // Reset remaining time
        end else begin
            case(state)
                COUNT: begin
                    if (counter == (delay + 1) * COUNT_DONE) begin
                        counter <= 13'b0; // Reset counter
                        remaining_time <= delay; // Set remaining time
                    end else if (counter % COUNT_DONE == 0) begin
                        remaining_time <= remaining_time - 1; // Decrement remaining time
                    end
                end
            endcase
        end
    end
    
    // Output signals
    assign count = counting ? remaining_time : 4'bxxxx; // Output count value
endmodule
