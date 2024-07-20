module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg done;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000;      // initialize state to BYTE1
    else begin
        case (state)
            3'b000: begin       // BYTE1 state
                if (in[2] == 1)
                    state <= 3'b001;  // transition to BYTE2
                else
                    state <= 3'b000;  // stay in BYTE1
            end
            3'b001: begin       // BYTE2 state
                state <= 3'b010;      // transition to BYTE3
            end
            3'b010: begin       // BYTE3 state
                state <= 3'b011;      // transition to DONE
            end
            3'b011: begin       // DONE state
                if (in[2] == 1)
                    state <= 3'b001;  // transition back to BYTE2
                else
                    state <= 3'b000;  // transition back to BYTE1
            end
        endcase
    end
end

always @(state) begin
    if (state == 3'b011)       // DONE state
        done = 1'b1;
    else
        done = 1'b0;
end

endmodule
