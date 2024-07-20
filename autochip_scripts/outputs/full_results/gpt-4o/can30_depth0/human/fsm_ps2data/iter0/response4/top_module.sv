module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    
    // Register to store bytes
    reg [23:0] message;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3] == 1) // Check if in[3] is 1
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

    // Output logic and message storage
    always @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'bx;
            done <= 0;
            message <= 24'b0;
        end else begin
            done <= 0; // Default to not done
            
            case (current_state)
                IDLE: begin
                    message <= 24'b0; // Clear message when idle
                end
                
                BYTE1: begin
                    message[23:16] <= in; // Store first byte
                end
                
                BYTE2: begin
                    message[15:8] <= in; // Store second byte
                end
                
                BYTE3: begin
                    message[7:0] <= in;    // Store third byte
                    out_bytes <= {message[23:8], in}; // Update output bytes
                    done <= 1; // Signal done
                end
            endcase
        end
    end

endmodule
