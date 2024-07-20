module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

// Define the states of the finite state machine
localparam STATE_FIND_FIRST_BYTE = 0;
localparam STATE_RECEIVE_SECOND_BYTE = 1;
localparam STATE_RECEIVE_THIRD_BYTE = 2;

// Define the current and next states
reg [1:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_FIND_FIRST_BYTE;
        done <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    // Default next state is to stay in the current state
    next_state = current_state;
    
    case (current_state)
        STATE_FIND_FIRST_BYTE: begin
            // Wait for a byte with in[3] = 1
            if (in[3]) begin
                next_state = STATE_RECEIVE_SECOND_BYTE;
            end
        end
        STATE_RECEIVE_SECOND_BYTE: begin
            // Receive the second byte
            next_state = STATE_RECEIVE_THIRD_BYTE;
        end
        STATE_RECEIVE_THIRD_BYTE: begin
            // Receive the third byte and signal 'done'
            done = 1'b1;
            next_state = STATE_FIND_FIRST_BYTE;
        end
        default: begin
            next_state = STATE_FIND_FIRST_BYTE;
        end
    endcase
end

endmodule
