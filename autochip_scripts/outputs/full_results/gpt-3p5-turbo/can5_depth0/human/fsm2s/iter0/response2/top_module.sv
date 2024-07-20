module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b0;  // Initial state: OFF
        end else begin
            case (state)
                2'b00: begin  // OFF state
                    if (j) begin
                        state <= 2'b01;  // Transition to ON state
                    end else begin
                        state <= 2'b00;  // Stay in OFF state
                    end
                end
                2'b01: begin  // ON state
                    if (k) begin
                        state <= 2'b00;  // Transition to OFF state
                    end else begin
                        state <= 2'b01;  // Stay in ON state
                    end
                end
                default: state <= 2'b00;  // Default state: OFF
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: out = 1'b0;  // OFF state, output is 0
            2'b01: out = 1'b1;  // ON state, output is 1
        endcase
    end

endmodule
