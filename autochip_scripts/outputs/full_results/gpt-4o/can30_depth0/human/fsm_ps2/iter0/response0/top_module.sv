module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        WAIT_FIRST_BYTE = 2'b00,
        WAIT_SECOND_BYTE = 2'b01,
        WAIT_THIRD_BYTE = 2'b10,
        MESSAGE_RECEIVED = 2'b11
    } state_t;

    reg [1:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            WAIT_FIRST_BYTE: begin
                if (in[3] == 1'b1)
                    next_state = WAIT_SECOND_BYTE;
                else
                    next_state = WAIT_FIRST_BYTE;
            end
            
            WAIT_SECOND_BYTE: begin
                next_state = WAIT_THIRD_BYTE;
            end
            
            WAIT_THIRD_BYTE: begin
                next_state = MESSAGE_RECEIVED;
            end
            
            MESSAGE_RECEIVED: begin
                next_state = WAIT_FIRST_BYTE;
            end
            
            default: begin
                next_state = WAIT_FIRST_BYTE;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            done <= 1'b0;
            current_state <= WAIT_FIRST_BYTE;
        end
        else begin
            current_state <= next_state;
            
            if (current_state == MESSAGE_RECEIVED)
                done <= 1'b1;
            else
                done <= 1'b0;
        end
    end

endmodule
