module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // Define states
    typedef enum logic [2:0] {
        IDLE,
        DETECT_PATTERN,
        SHIFT_ENA,
        COUNTING,
        NOTIFY,
        WAIT_ACK
    } state_t;
    
    // Define signals
    reg [2:0] state;
    reg [3:0] counter;
    wire pattern_detected;
    
    // Detect pattern
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else begin
            case (state)
                IDLE:
                    if (data == 4'b1101)
                        state <= DETECT_PATTERN;
                    else
                        state <= IDLE;
                DETECT_PATTERN:
                    if (pattern_detected)
                        state <= SHIFT_ENA;
                    else
                        state <= DETECT_PATTERN;
                SHIFT_ENA:
                    state <= COUNTING;
                COUNTING:
                    if (done_counting)
                        state <= NOTIFY;
                    else
                        state <= COUNTING;
                NOTIFY:
                    if (ack)
                        state <= WAIT_ACK;
                    else
                        state <= NOTIFY;
                WAIT_ACK:
                    if (reset)
                        state <= IDLE;
                    else
                        state <= WAIT_ACK;
                default:
                    state <= IDLE;
            endcase
        end
    end
    
    // Detect pattern
    assign pattern_detected = (data == 4'b1101);
    
    // Enable shift
    always @(posedge clk) begin
        if (state == SHIFT_ENA)
            shift_ena <= 1;
        else
            shift_ena <= 0;
    end
    
    // Indicate counting
    always @(posedge clk) begin
        if (state == COUNTING)
            counting <= 1;
        else
            counting <= 0;
    end
    
    // Notify done
    always @(posedge clk) begin
        if (state == NOTIFY)
            done <= 1;
        else
            done <= 0;
    end
    
endmodule
