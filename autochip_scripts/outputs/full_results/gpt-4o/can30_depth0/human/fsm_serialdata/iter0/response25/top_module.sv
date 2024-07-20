module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE      = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT  = 3'b011,
        WAIT_IDLE = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;
    
    // Update state / FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state      <= IDLE;
            bit_count  <= 3'd0;
            shift_reg  <= 8'd0;
            out_byte   <= 8'd0;
            done       <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    if (in == 1'b0) // detect start bit
                        next_state <= START_BIT;
                    else
                        next_state <= IDLE;
                end
                
                START_BIT: begin
                    next_state <= DATA_BITS;
                    bit_count <= 3'd0;
                end
                
                DATA_BITS: begin
                    shift_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                    if (bit_count == 3'd7)
                        next_state <= STOP_BIT;
                    else
                        next_state <= DATA_BITS;
                end
                
                STOP_BIT: begin
                    if (in == 1'b1) begin // correct stop bit
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= WAIT_IDLE;
                    end
                    else begin // incorrect stop bit, wait for another stop bit
                        next_state <= WAIT_IDLE;
                    end
                end
                
                WAIT_IDLE: begin
                    if (in == 1'b1) begin // detect line idle (stop bit)
                        next_state <= IDLE;
                        done <= 1'b0;
                    end
                    else
                        next_state <= WAIT_IDLE;
                end
                
                default: next_state <= IDLE;
            endcase
        end
    end

    // Determine next state
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // detect start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
            end
            
            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            
            STOP_BIT: begin
                if (in == 1'b1) // correct stop bit
                    next_state = WAIT_IDLE;
                else // incorrect stop bit, wait for another stop bit
                    next_state = WAIT_IDLE;
            end
            
            WAIT_IDLE: begin
                if (in == 1'b1) // detect line idle (stop bit)
                    next_state = IDLE;
                else
                    next_state = WAIT_IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
