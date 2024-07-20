module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define state encoding
    typedef enum reg [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] shift_reg;
    
    // State transition logic
    always @(*) begin
        case (state)
            BYTE1: 
                if (in[3])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            BYTE2:
                next_state = BYTE3;
            BYTE3:
                next_state = DONE;
            DONE:
                if (in[3])
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            default:
                next_state = BYTE1; // Handle all undefined states by returning to BYTE1
        endcase
    end
    
    // Sequential logic for state and shift register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state != DONE) begin
                shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and add new input
            end
            
            if (state == BYTE3)
                out_bytes <= shift_reg;
                
            // Set the done signal
            done <= (state == DONE);
        end
    end
    
endmodule
