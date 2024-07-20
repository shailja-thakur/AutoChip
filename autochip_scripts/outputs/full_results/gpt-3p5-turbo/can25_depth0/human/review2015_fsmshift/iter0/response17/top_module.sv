module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    if (bit_pattern_detected) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b000;
                    end
                end
                3'b001: begin
                    shift_ena <= 1;
                    state <= 3'b010;
                end
                3'b010: begin
                    shift_ena <= 1;
                    state <= 3'b011;
                end
                3'b011: begin
                    shift_ena <= 1;
                    state <= 3'b100;
                end
                3'b100: begin
                    shift_ena <= 1;
                    state <= 3'b101;
                end
                3'b101: begin
                    shift_ena <= 1;
                    state <= 3'b110;
                end
                3'b110: begin
                    shift_ena <= 1;
                    state <= 3'b111;
                end
                3'b111: begin
                    shift_ena <= 1;
                    state <= 3'b000;
                end
            endcase
        end
    end

endmodule
