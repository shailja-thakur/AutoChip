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
                    state <= 3'b001; // B0 -> B1
                end
                3'b001: begin
                    state <= 3'b010; // B1 -> B2
                end
                3'b010: begin
                    state <= 3'b011; // B2 -> B3
                end
                3'b011: begin
                    state <= 3'b100; // B3 -> Done
                end
                default: begin
                    state <= 3'b100; // Done
                end
            endcase
        end
    end

    assign shift_ena = (state != 3'b000);

endmodule
