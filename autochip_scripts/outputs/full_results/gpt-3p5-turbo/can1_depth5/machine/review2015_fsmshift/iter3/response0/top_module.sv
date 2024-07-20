module top_module(
    input clk,
    input reset,
    output wire shift_ena,
    output reg [2:0] state);

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // B0
        end else begin
            case (state)
                3'b000: begin
                    state <= 3'b001; // B1
                end
                3'b001: begin
                    state <= 3'b010; // B2
                end
                3'b010: begin
                    state <= 3'b011; // B3
                end
                3'b011: begin
                    state <= 3'b100; // Done
                end
                default: begin
                    state <= 3'b100; // Done
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset == 1'b1 || state >= 3'b100) begin
            shift_ena <= 1'b0;
        end else begin
            shift_ena <= 1'b1;
        end
    end

endmodule
