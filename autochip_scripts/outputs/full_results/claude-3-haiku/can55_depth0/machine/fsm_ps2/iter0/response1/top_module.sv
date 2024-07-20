module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Define the states
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE = 2'b11;

    // Declare the current state and next state registers
    reg [1:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= BYTE1;
            done <= 0;
        end
        else begin
            current_state <= next_state;
            case (current_state)
                BYTE1: begin
                    if (in[2]) begin
                        next_state <= BYTE2;
                    end
                    else begin
                        next_state <= BYTE1;
                    end
                end
                BYTE2: begin
                    next_state <= BYTE3;
                end
                BYTE3: begin
                    next_state <= DONE;
                end
                DONE: begin
                    if (in[2]) begin
                        next_state <= BYTE2;
                    end
                    else begin
                        next_state <= BYTE1;
                    end
                    done <= 1;
                end
                default: begin
                    next_state <= BYTE1;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
