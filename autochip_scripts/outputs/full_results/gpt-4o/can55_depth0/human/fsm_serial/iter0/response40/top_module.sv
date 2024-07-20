module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        WAIT    = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    
    // State transition logic (combinatorial)
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            
            WAIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // State Register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Bit counter and done signal logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    bit_count <= 3'b0;
                    done <= 1'b0;
                end
                
                START: begin
                    bit_count <= 3'b0;
                    done <= 1'b0;
                end
                
                DATA: begin
                    bit_count <= bit_count + 1'b1;
                    done <= 1'b0;
                end
                
                STOP: begin
                    done <= 1'b1;
                end
                
                WAIT: begin
                    done <= 1'b0;
                end
                
                default: begin
                    bit_count <= 3'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
