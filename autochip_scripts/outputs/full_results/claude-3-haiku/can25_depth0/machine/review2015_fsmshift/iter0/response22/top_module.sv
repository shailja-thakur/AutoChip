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
                3'b000: // B0
                    state <= 3'b001; // B1
                3'b001: // B1
                    state <= 3'b010; // B2
                3'b010: // B2
                    state <= 3'b011; // B3
                3'b011: // B3
                    state <= 3'b100; // Done
                3'b100: // Done
                    state <= 3'b000; // B0
                default:
                    state <= 3'b100; // Done
            endcase
        end
    end

    always @(*) begin
        case (state)
            3'b000, 3'b001, 3'b010, 3'b011: // B0, B1, B2, B3
                shift_ena = 1'b1;
            3'b100: // Done
                shift_ena = 1'b0;
            default:
                shift_ena = 1'b0;
        endcase
    end

endmodule
