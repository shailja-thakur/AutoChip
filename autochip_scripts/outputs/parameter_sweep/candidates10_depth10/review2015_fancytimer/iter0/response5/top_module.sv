module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    // Define states for the state machine
    localparam IDLE_STATE = 2'b00;
    localparam DETECT_STATE = 2'b01;
    localparam COUNT_STATE = 2'b10;
    localparam DONE_STATE = 2'b11;
    
    // Internal signals
    reg [1:0] state;
    reg [3:0] delay;
    reg [3:0] timer_count;
    wire detect;
    
    // Counter for counting clock cycles
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            timer_count <= 0;
        end else begin
            if (counting) begin
                if (timer_count == (delay + 1) * 1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                end else begin
                    timer_count <= timer_count + 1;
                end
            end else begin
                timer_count <= 0;
            end
        end
    end
    
    // State machine
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE_STATE;
            delay <= 0;
        end else begin
            case (state)
                IDLE_STATE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_STATE;
                    end
                end
                DETECT_STATE: begin
                    state <= COUNT_STATE;
                    delay <= data;
                end
                COUNT_STATE: begin
                    if (timer_count == (delay + 1) * 1000 - 1) begin
                        state <= DONE_STATE;
                    end
                end
                DONE_STATE: begin
                    if (ack)
                        state <= IDLE_STATE;
                end
            endcase
        end
    end
    
    // Output signals
    assign detect = (data == 4'b1101) && (state == DETECT_STATE);
    assign count = counting ? (delay - (timer_count / 1000)) : 4'bzzzz;
    
endmodule
