module top_module(
    input clk,
    input reset,
    output shift_ena);

    reg [2:0] state;
    reg shift_ena;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            shift_ena <= 1'b1;
        end else begin
            case (state)
                3'b000: begin      // Idle state
                    if (bit_pattern_detected) begin
                        state <= 3'b001;
                        shift_ena <= 1'b1;
                    end else begin
                        state <= 3'b000;
                        shift_ena <= 1'b0;
                    end
                end
                3'b001: begin      // Enable state
                    state <= 3'b010;
                    shift_ena <= 1'b1;
                end
                3'b010: begin      // Shift state
                    state <= 3'b011;
                    shift_ena <= 1'b1;
                end
                3'b011: begin      // Shift state
                    state <= 3'b100;
                    shift_ena <= 1'b1;
                end
                3'b100: begin      // Shift state
                    state <= 3'b101;
                    shift_ena <= 1'b1;
                end
                3'b101: begin      // Shift state
                    state <= 3'b000;
                    shift_ena <= 1'b0;
                end
                default: begin     // Default state
                    state <= 3'b000;
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end

    // Other module code to detect bit pattern and control shift register

endmodule
