module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state;
    reg [2:0] w_history;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            w_history <= 3'b000;
            z <= 1'b0;
        end else begin
            case (state)
                2'b00: // State A
                    begin
                        if (s == 1'b1)
                            state <= 2'b01; // Move to State B
                        else
                            state <= 2'b00;
                    end
                2'b01: // State B
                    begin
                        w_history <= {w_history[1:0], w}; // Shift in new value of w

                        if (w_history == 3'b011 || w_history == 3'b101 || w_history == 3'b110)
                            z <= 1'b1;
                        else
                            z <= 1'b0;

                        state <= 2'b01; // Stay in State B
                    end
                default: // Should never occur
                    state <= 2'b00;
            endcase
        end
    end
endmodule
