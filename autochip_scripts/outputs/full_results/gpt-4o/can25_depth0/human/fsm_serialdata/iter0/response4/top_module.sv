module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] byte_reg;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                if (in == 1'b0) // start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                done = 1'b0;
                if (in == 1'b0) // still in start bit
                    next_state = RECEIVE;
                else
                    next_state = IDLE; // false start
            end
            
            RECEIVE: begin
                done = 1'b0;
                if (bit_counter == 3'd7)
                    next_state = STOP;
                else
                    next_state = RECEIVE;
            end
            
            STOP: begin
                if (in == 1'b1) begin // valid stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    done = 1'b0;
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                done = 1'b0;
                if (in == 1'b1) // wait for stop bit
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
        endcase
    end
    
    // Output and data handling logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 3'd0;
            byte_reg <= 8'b0;
            out_byte <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_counter <= 3'd0;
                    byte_reg <= 8'b0;
                end
                
                START: begin
                    // Nothing to do, just transition state
                end
                
                RECEIVE: begin
                    byte_reg[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= byte_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end

                ERROR: begin
                    // Nothing to do, just wait for stop bit
                end
            endcase
        end
    end
    
endmodule
