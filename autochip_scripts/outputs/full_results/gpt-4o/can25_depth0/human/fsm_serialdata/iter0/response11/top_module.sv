module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    typedef enum reg [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        RECEIVE   = 3'b010,
        STOP_BIT  = 3'b011,
        DONE      = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_shift_reg;
    
    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic and Output Logic
    always @(*) begin
        next_state = state; // Default to the same state by default
        done = 1'b0; // Default done to 0
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect the start bit
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                next_state = RECEIVE;
            end
            
            RECEIVE: begin
                if (bit_counter == 3'd7)
                    next_state = STOP_BIT;
            end
            
            STOP_BIT: begin
                if (in == 1'b1) // Detect the stop bit
                    next_state = DONE;
                else
                    next_state = IDLE; // Wait for the correct stop bit
            end
            
            DONE: begin
                done = 1'b1;
                next_state = IDLE; // Go back to idle after done
            end
        endcase
    end
    
    // Bit counter and data shift register
    always @(posedge clk) begin
        if (reset) begin
            bit_counter <= 3'd0;
            data_shift_reg <= 8'd0;
        end else if (state == RECEIVE) begin
            bit_counter <= bit_counter + 1'b1;
            data_shift_reg <= {in, data_shift_reg[7:1]};
        end else if (state == IDLE) begin
            bit_counter <= 3'd0;
        end
    end
    
    // Capture byte when in DONE state
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'd0;
        end else if (state == DONE) begin
            out_byte <= data_shift_reg;
        end
    end

endmodule
