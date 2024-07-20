module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // B0
        end
        else begin
            case (state)
                3'b000: state <= 3'b001; // B0 -> B1
                3'b001: state <= 3'b010; // B1 -> B2
                3'b010: state <= 3'b011; // B2 -> B3
                3'b011: state <= 3'b100; // B3 -> Done
                3'b100: state <= 3'b100; // Stay in Done state
                default: state <= 3'b000; // Any other state, go to B0
            endcase
        end
    end

    always @(*) begin
        // Assign shift_ena based on the current state
        shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);
    end

endmodule
