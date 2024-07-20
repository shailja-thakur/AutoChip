module top_module (
    input wire clk,
    input wire in,
    input wire areset,
    output wire out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b01; // reset to state B
        else begin
            case (state)
                2'b00: // A
                    state <= in ? 2'b00 : 2'b01;
                2'b01: // B
                    state <= in ? 2'b10 : 2'b01;
                2'b10: // C
                    state <= in ? 2'b00 : 2'b01;
                default:
                    state <= 2'b00; // default state B
            endcase
        end
    end

    always @(posedge clk) begin
        case (state)
            2'b00: // A
                out_reg <= 1'b0;
            default: // B, C
                out_reg <= 1'b1;
        endcase
    end

    assign out = out_reg;

endmodule
