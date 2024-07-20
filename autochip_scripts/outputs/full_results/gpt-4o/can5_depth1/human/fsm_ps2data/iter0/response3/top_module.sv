module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State declarations
    typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
    state_t state, next_state;
    
    // Registers to store bytes
    reg [7:0] byte1, byte2, byte3;

    // State transition logic
    always @(posedge clk) begin
        if (reset) 
            state <= IDLE;
        else 
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                if (in[3]) 
                    next_state = BYTE1;
                else 
                    next_state = IDLE;
            
            BYTE1: 
                next_state = BYTE2;
            
            BYTE2: 
                next_state = BYTE3;
            
            BYTE3: 
                next_state = IDLE;
            
            default: 
                next_state = IDLE;
        endcase
    end

    // Output and state updates
    always @(posedge clk) begin
        if (reset) begin
            {byte1, byte2, byte3} <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                end
                BYTE1: begin
                    byte1 <= in;
                    done <= 0;
                end
                BYTE2: begin
                    byte2 <= in;
                    done <= 0;
                end
                BYTE3: begin
                    byte3 <= in;
                    out_bytes <= {byte1, byte2, byte3};
                    done <= 1;
                end
            endcase
        end
    end
        
endmodule
