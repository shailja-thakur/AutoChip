module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000; // State A
        end else begin
            case (state)
                3'b000: // State A
                    if (w) begin
                        state <= 3'b000; // State A
                    end else begin
                        state <= 3'b001; // State B
                    end
                3'b001: // State B
                    if (w) begin
                        state <= 3'b010; // State D
                    end else begin
                        state <= 3'b011; // State C
                    end
                3'b010: // State D
                    if (w) begin
                        state <= 3'b000; // State A
                    end else begin
                        state <= 3'b101; // State F
                    end
                3'b011: // State C
                    if (w) begin
                        state <= 3'b010; // State D
                    end else begin
                        state <= 3'b100; // State E
                    end
                3'b100: // State E
                    if (w) begin
                        state <= 3'b010; // State D
                    end else begin
                        state <= 3'b100; // State E
                    end
                3'b101: // State F
                    if (w) begin
                        state <= 3'b010; // State D
                    end else begin
                        state <= 3'b011; // State C
                    end
            endcase
        end
    end

    always @(*) begin
        case (state)
            3'b100: // State E
            3'b101: // State F
                z = 1'b1;
            default:
                z = 1'b0;
        endcase
    end

endmodule
