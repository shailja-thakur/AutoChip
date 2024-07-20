module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // FSM state encoding
    typedef enum reg [1:0] {
        IDLE  = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t state, next_state;

    // Registers to hold the 3 bytes
    reg [7:0] byte1, byte2, byte3;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) 
                    next_state = BYTE1;
                else 
                    next_state = IDLE;
            end
            
            BYTE1: next_state = BYTE2;
            
            BYTE2: next_state = BYTE3;
            
            BYTE3: next_state = IDLE;

            default: next_state = IDLE;
        endcase
    end

    // FSM state update and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
            out_bytes <= 24'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                
                BYTE1: begin
                    byte1 <= in;
                    done <= 1'b0;
                end
                
                BYTE2: begin
                    byte2 <= in;
                    done <= 1'b0;
                end
                
                BYTE3: begin
                    byte3 <= in;
                    done <= 1'b1;
                    out_bytes <= {byte1, byte2, byte3};
                end
            endcase
        end
    end

endmodule
