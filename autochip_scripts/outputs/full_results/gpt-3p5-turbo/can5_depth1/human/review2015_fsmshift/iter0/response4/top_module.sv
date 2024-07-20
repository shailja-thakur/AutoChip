module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    reg [3:0] counter;

    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter ENABLE = 2;

    // FSM
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            case (state)
                IDLE:
                    if (/* Add bit pattern detection condition */) begin
                        state <= DETECT;
                        counter <= 0;
                    end
                DETECT:
                    if (counter == 3) begin
                        state <= ENABLE;
                        counter <= 0;
                    end else begin
                        counter <= counter + 1;
                    end
                ENABLE:
                    state <= IDLE;
            endcase
        end
    end

    // Enable generation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 1'b0;
        end else begin
            if (state == ENABLE && counter < 4) begin
                shift_ena <= 1'b1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule
