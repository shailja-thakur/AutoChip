module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    output reg done,
    input done_counting,
    input ack );

    // Create state register
    reg [3:0] state;
    reg [3:0] next_state;

    // Create output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000; // Initialize state to search for input sequence 1101
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end 
        else begin
            state <= next_state; // Update state
        end
    end

    always @(state or done_counting or ack) begin
        case (state)
            4'b0000: begin // Idle state, searching for input sequence 1101
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                if (data == 4'b1101) // Input sequence detected
                    next_state = 4'b0001; // Go to next state: shift_ena for 4 clock cycles
                else 
                    next_state = 4'b0000; // Stay in idle state
            end
            4'b0001: begin // State: shift_ena for 4 clock cycles
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
                next_state = 4'b0010; // Go to next state: counting
            end
            4'b0010: begin // State: counting
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
                if (done_counting) // Counters finished counting
                    next_state = 4'b0011; // Go to next state: done
                else
                    next_state = 4'b0010; // Stay in counting state
            end
            4'b0011: begin // State: done
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
                if (ack) // User acknowledged the timer
                    next_state = 4'b0000; // Go back to idle state to search for the next occurrence of the start sequence 1101
                else
                    next_state = 4'b0011; // Stay in done state
            end
            default: begin // Catch-all state for any unknown state values
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                next_state = 4'b0000;
            end
        endcase
    end

endmodule
