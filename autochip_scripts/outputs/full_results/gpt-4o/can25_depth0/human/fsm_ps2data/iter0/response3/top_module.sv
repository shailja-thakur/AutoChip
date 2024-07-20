module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        IDLE,
        BYTE1,
        BYTE2,
        BYTE3
    } state_t;
    
    // State registers
    state_t current_state, next_state;
    reg [23:0] message;   // Register to store the received message
    
    // State machine sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_bytes <= 0;
            done <= 0;
            message <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == BYTE3) begin
                out_bytes <= message;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end
    
    // State machine combinational logic
    always @(*) begin
        // Default next state and message behavior
        next_state = current_state;
        message = message;
        
        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                    message[23:16] = in;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
                message[15:8] = in;
            end
            BYTE2: begin
                next_state = BYTE3;
                message[7:0] = in;
            end
            BYTE3: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
