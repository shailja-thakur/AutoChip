module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 2'b10; // B state
    else
    begin
        case(state)
            2'b00: // A state
                begin
                    if (in)
                        state <= 2'b01; // A state
                    else
                        state <= 2'b10; // B state
                end
            2'b01: // B state
                begin
                    if (in)
                        state <= 2'b01; // B state
                    else
                        state <= 2'b10; // A state
                end
            default:
                state <= 2'b10; // B state (reset state)
        endcase
    end
end

always @(state)
begin
    case(state)
        2'b00: out = 0; // A state
        2'b01: out = 1; // B state
        default: out = 1; // B state (reset state)
    endcase
end

endmodule
