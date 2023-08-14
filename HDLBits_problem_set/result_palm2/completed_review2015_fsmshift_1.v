module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    // The state machine has two states:
    //   - `IDLE`: The shift register is not enabled.
    //   - `SHIFT`: The shift register is enabled.

    reg [1:0] state = IDLE;
    reg [3:0] shift_count = 0;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (shift_count == 4) begin
                        state <= IDLE;
                        shift_count <= 0;
                    end else begin
                        state <= SHIFT;
                        shift_count <= shift_count + 1;
                    end
                end
                SHIFT: begin
                    if (shift_count == 4) begin
                        state <= IDLE;
                        shift_count <= 0;
                    end
                end
            endcase
        end
    end

    assign shift_ena = state == SHIFT;

endmodule