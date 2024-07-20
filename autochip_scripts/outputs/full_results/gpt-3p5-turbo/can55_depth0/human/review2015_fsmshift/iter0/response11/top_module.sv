module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    reg [3:0] counter;

    parameter IDLE = 0;
    parameter DETECTED = 1;
    parameter ENABLED = 2;

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state <= IDLE;
            counter <= 0;
            shift_ena <= 1;
        end
        else
        begin
            case (state)
                IDLE: begin
                    if (/* condition for pattern detection */)
                    begin
                        state <= DETECTED;
                    end
                end

                DETECTED: begin
                    state <= ENABLED;
                    counter <= 4;
                    shift_ena <= 1;
                end

                ENABLED: begin
                    if (counter == 0)
                    begin
                        state <= IDLE;
                        shift_ena <= 0;
                    end
                    else
                    begin
                        counter <= counter - 1;
                    end
                end
            endcase
        end
    end

endmodule
