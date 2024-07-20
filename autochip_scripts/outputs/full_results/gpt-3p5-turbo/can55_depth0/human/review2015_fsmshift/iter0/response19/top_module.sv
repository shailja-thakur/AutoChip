module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    parameter IDLE = 0, DETECT_PATTERN = 1, SHIFT_ENA = 2;
    reg [3:0] count;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            shift_ena <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (/* condition for detecting the bit pattern */) begin
                        state <= DETECT_PATTERN;
                        count <= 0;
                        shift_ena <= 0;
                    end
                end
                DETECT_PATTERN: begin
                    if (count == 3) begin
                        state <= SHIFT_ENA;
                        count <= 0;
                        shift_ena <= 1;
                    end else begin
                        count <= count + 1;
                    end
                end
                SHIFT_ENA: begin
                    if (count == 3) begin
                        state <= IDLE;
                        count <= 0;
                        shift_ena <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end
                default: begin
                    state <= IDLE;
                    count <= 0;
                    shift_ena <= 0;
                end
            endcase
        end
    end

endmodule
