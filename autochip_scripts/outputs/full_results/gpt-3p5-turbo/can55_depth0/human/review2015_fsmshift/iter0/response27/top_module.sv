module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [3:0] shift_counter;
    reg [1:0] state;
    
    parameter IDLE = 0;
    parameter COUNT = 1;
    parameter DISABLE = 2;
    
    always @(posedge clk) begin
        if (reset) begin
            shift_counter <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (shift_counter == 4'b0000) begin
                        if (input_pattern_detected()) begin
                            shift_counter <= 4'b1111;
                            state <= COUNT;
                        end
                    end
                end

                COUNT: begin
                    shift_counter <= shift_counter - 1;
                    if (shift_counter == 4'b0000) begin
                        shift_ena <= 0;
                        state <= DISABLE;
                    end
                end

                DISABLE: begin
                    shift_ena <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end

    function automatic input_pattern_detected;
        // Add your input pattern detection logic here
        // Return 1 if the proper bit pattern is detected, 0 otherwise
        return 1;
    endfunction

endmodule
