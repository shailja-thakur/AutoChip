module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(state, j, k) begin
        case (state)
            2'b00: // OFF
                if (j)
                    next_state = 2'b01; // ON
                else
                    next_state = 2'b00; // OFF
            2'b01: // ON
                if (k)
                    next_state = 2'b00; // OFF
                else
                    next_state = 2'b01; // ON
            default:
                next_state = 2'b00;
        endcase
    end

    always @(state) begin
        case (state)
            2'b00: // OFF
                out = 1'b0;
            2'b01: // ON
                out = 1'b1;
            default:
                out = 1'b0;
        endcase
    end
endmodule
