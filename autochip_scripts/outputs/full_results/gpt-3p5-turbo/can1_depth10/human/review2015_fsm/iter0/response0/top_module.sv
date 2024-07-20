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
    reg [2:0] state;

    // Create next state logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000; // Initialize state to search for input sequence 1101
        end 
        else begin
            case (state)
                3'b000: begin // Idle state, searching for input sequence 1101
                    if (data == 4'b1101) // Input sequence detected
                        state <= 3'b001; // Go to next state: shift_ena for 4 clock cycles
                    else
                        state <= 3'b000; // Stay in idle state
                end
                3'b001: begin // State: shift_ena for 4 clock cycles
                    state <= 3'b010; // Go to next state: counting
                end
                3'b010: begin // State: counting
                    if (done_counting) // Counters finished counting
                        state <= 3'b011; // Go to next state: done
                    else
                        state <= 3'b010; // Stay in counting state
                end
                3'b011: begin // State: done
                    if (ack) // User acknowledged the timer
                        state <= 3'b000; // Go back to idle state to search for the next occurrence of the start sequence 1101
                    else
                        state <= 3'b011; // Stay in done state
                end
            endcase
        end
    end

    // Create output logic
    always @(posedge clk) begin
        case (state)
            3'b001: begin // In state shift_ena for 4 clock cycles
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            3'b010: begin // In state counting
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            3'b011: begin // In state done
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end
            default: begin // In idle state
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end
endmodule
