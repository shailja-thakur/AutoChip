module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum {IDLE, START, DATA, STOP} state_t;
    state_t state, next_state;
    
    reg [2:0] bit_cnt; // Counter for the 8 data bits
    reg [7:0] data;    // Shift register to store received bits

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 3'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Synchronous state transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                if (in == 1'b0) // Confirm start bit
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            
            DATA: begin
                if (bit_cnt == 3'd7) // Last data bit received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    done = 1'b1;
                    next_state = IDLE;
                end else
                    next_state = STOP; // Wait until we find a stop bit
            end
            
            default: next_state = IDLE;
        endcase
    end

    // Shift register for storing bits and bit counter increment logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_cnt <= 3'd0;
            data <= 8'd0;
        end else begin
            if (state == START) begin
                bit_cnt <= 3'd0;
                data <= 8'd0;
            end else if (state == DATA) begin
                data <= {in, data[7:1]}; // Shift in the incoming bit LSB first
                bit_cnt <= bit_cnt + 1;
            end
        end
    end

endmodule
