module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic
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
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            
            BYTE1: begin
                next_state = BYTE2;
            end
            
            BYTE2: begin
                next_state = DONE;
            end
            
            DONE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
        end else begin
            case (current_state)
                DONE: done <= 1; // Signal done in the DONE state
                default: done <= 0;
            endcase
        end
    end

endmodule
