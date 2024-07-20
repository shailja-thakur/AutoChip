module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // FSM states
    typedef enum reg [1:0] {
        IDLE,       // Waiting for the first byte
        BYTE1,      // First byte received
        BYTE2,      // Second byte received
        BYTE3       // Third byte received, message complete
    } state_t;
    
    state_t state, next_state;
    reg [23:0] temp_bytes;
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_bytes <= 24'b0;
            temp_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == BYTE3) begin
                out_bytes <= temp_bytes;
                done <= 1'b1;
            end else if (state == BYTE3) begin
                done <= 1'b0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    temp_bytes[23:16] = in;
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            
            BYTE1: begin
                temp_bytes[15:8] = in;
                next_state = BYTE2;
            end
            
            BYTE2: begin
                temp_bytes[7:0] = in;
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = IDLE;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
