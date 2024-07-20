module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);

    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // B0
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            next_state <= 3'b000; // B0
        end else begin
            case (state)
                3'b000: // B0
                    next_state <= 3'b001; // B1
                3'b001: // B1
                    next_state <= 3'b010; // B2
                3'b010: // B2
                    next_state <= 3'b011; // B3
                3'b011: // B3
                    next_state <= 3'b100; // Done
                default:
                    next_state <= 3'b100; // Done
            endcase
        end
    end

    assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
