module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] countdown;
    reg [3:0] remain_time;
    reg [3:0] state;
    reg [3:0] next_state;
    
    // State definitions
    parameter START = 4'b0000;
    parameter SHIFT_IN = 4'b0001;
    parameter COUNTING = 4'b0010;
    parameter TIMED_OUT = 4'b0011;
    
    // Output assignment
	assign count = remain_time;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= START;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            counting <= (state == COUNTING) ? 1'b1 : 1'b0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
           delay <= 0;
           countdown <= 0;
           remain_time <= 0;
        end else begin
            case(state)
                // START state
                START: begin
                    if (data == 4'b1101) begin
                        delay <= data[3:0];
                        state <= SHIFT_IN;
                    end
                end
                
                // SHIFT_IN state
                SHIFT_IN: begin
                    countdown <= delay;
                    remain_time <= delay;
                    state <= COUNTING;
                end
                
                // COUNTING state
                COUNTING: begin
                    if (countdown > 0) begin
                        countdown <= countdown - 1;
                        remain_time <= remain_time - 1;
                    end else begin
                        state <= TIMED_OUT;
                    end
                end
                
                // TIMED_OUT state
                TIMED_OUT: begin
                    if (ack) begin
                        state <= START;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end
    
endmodule
