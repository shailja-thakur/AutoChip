module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Create state register
    reg [3:0] state;

    // Create next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000; // Initialize state to search for input sequence 1101
        end 
        else begin
            case (state)
                4'b0000: begin // Idle state, searching for input sequence 1101
                    if (data == 4'b1101) // Input sequence detected
                        state <= 4'b0001; // Go to next state: shift_ena for 4 clock cycles
                    else
                        state <= 4'b0000; // Stay in idle state
                end
                4'b0001: begin // State: shift_ena for 4 clock cycles
                    state <= 4'b0010; // Go to next state: counting
                end
                4'b0010: begin // State: counting
                    if (done_counting) // Counters finished counting
                        state <= 4'b0011; // Go to next state: done
                end
                4'b0011: begin // State: done
                    if (ack) // User acknowledged the timer
                        state <= 4'b0000; // Go back to idle state to search for the next occurrence of the start sequence 1101
                end
                default: begin // Catch-all state for any unknown state values
                    state <= 4'b0000;
                end
            endcase
        end
    end

    // Create output logic
    always @(posedge clk) begin
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        case (state)
            4'b0000: begin // In idle state
                if (data == 4'b1101)
                    shift_ena <= 1'b1;
            end
            4'b0001: begin // In state shift_ena for 4 clock cycles
                shift_ena <= 1'b1;
            end
            4'b0010: begin // In state counting
                counting <= 1'b1;
            end
            4'b0011: begin // In state done
                done <= 1'b1;
            end
        endcase
    end
endmodule
