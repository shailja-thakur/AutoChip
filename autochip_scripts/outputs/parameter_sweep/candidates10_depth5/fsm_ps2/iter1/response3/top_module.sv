module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] prev_in;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin  // Idle state
                if (in[3] == 1) begin
                    state <= 1;  // Transition to first byte state
                    prev_in <= in;
                end
            end
            1: begin  // First byte state
                state <= 2;  // Transition to second byte state
                prev_in <= in;
            end
            2: begin  // Second byte state
                state <= 3;  // Transition to third byte state
                prev_in <= in;
            end
            3: begin  // Third byte state
                state <= 0;  // Transition back to idle state
                prev_in <= in;
            end
        endcase
    end
end

assign done = (state == 3) && (prev_in[3] == 1);

endmodule
