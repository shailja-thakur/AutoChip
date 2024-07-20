module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    
    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        START_BIT,
        DATA_BIT0,
        DATA_BIT1,
        DATA_BIT2,
        DATA_BIT3,
        DATA_BIT4,
        DATA_BIT5,
        DATA_BIT6,
        DATA_BIT7,
        STOP_BIT
    } state_t;
    
    state_t state, next_state;
    reg [7:0] data;
    reg [2:0] bit_count;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic for next state
    always @(*) begin
        next_state = state;  // Default to staying in current state
        done = 0;
        case (state)
            IDLE: begin
                if (!in)  // Start bit detected
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = DATA_BIT0;  // Proceed to receiving data bits
            end
            DATA_BIT0: next_state = DATA_BIT1;
            DATA_BIT1: next_state = DATA_BIT2;
            DATA_BIT2: next_state = DATA_BIT3;
            DATA_BIT3: next_state = DATA_BIT4;
            DATA_BIT4: next_state = DATA_BIT5;
            DATA_BIT5: next_state = DATA_BIT6;
            DATA_BIT6: next_state = DATA_BIT7;
            DATA_BIT7: next_state = STOP_BIT;
            STOP_BIT: begin
                if (in) begin  // Stop bit detected
                    done = 1;
                    next_state = IDLE;
                end else begin  // Stop bit not detected
                    next_state = IDLE;  // Return to idle to search for next start bit
                end
            end
        endcase
    end
    
    // Data bit counting and storage
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 0;
            data <= 8'b0;
        end else begin
            if (state >= DATA_BIT0 && state <= DATA_BIT7) begin
                data[bit_count] <= in;
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 0;
            end
        end
    end
    
endmodule
