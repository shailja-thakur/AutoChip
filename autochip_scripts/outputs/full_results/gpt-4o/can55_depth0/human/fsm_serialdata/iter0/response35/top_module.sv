module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State machine states
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;
    state_t state, next_state;
    
    // Internal registers
    reg [2:0] bit_count; // 3-bit counter for the 8 data bits
    reg [7:0] shift_reg; // Register to hold the received data byte

    // Synchronous state and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
            shift_reg <= 8'b00000000;
            out_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                
                START: begin
                    // Do nothing special during start bit
                end
                
                DATA: begin
                    // Shift in the data bits (least significant bit first)
                    if (bit_count < 3'b111) begin
                        bit_count <= bit_count + 1;
                        shift_reg <= {in, shift_reg[7:1]};
                    end
                end
                
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to the same state unless changed
        
        case (state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_count == 3'b111)
                    next_state = STOP;
            end
            
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = STOP; // Wait until stop bit is 1
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
