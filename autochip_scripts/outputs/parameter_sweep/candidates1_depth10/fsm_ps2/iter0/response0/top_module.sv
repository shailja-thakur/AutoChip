module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state; // define state as a 3-bit register
reg done;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0; // reset the state to initial state
    else begin
        case (state)
            0: begin // State 0: Discard bytes until in[3]=1
                if (in[3] == 1)
                    state <= 1; // Move to State 1
                else
                    state <= 0; // Stay in State 0
            end
            1: begin // State 1: Waiting for byte 2
                state <= 2; // Move to State 2
            end
            2: begin // State 2: Waiting for byte 3
                if (in[3] == 1)
                    begin
                        state <= 0; // Move back to State 0
                        done <= 1; // Signal the receipt of a message
                    end
                else
                    state <= 2; // Stay in State 2
            end
        endcase
    end
end

endmodule
