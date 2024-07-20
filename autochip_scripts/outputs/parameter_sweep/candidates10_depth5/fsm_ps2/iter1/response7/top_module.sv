module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg reset_fedge;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        reset_fedge <= 1'b1;
    end else begin
        reset_fedge <= 1'b0;
        case (state)
            0: begin  // Idle state
                if (in[3] == 1) begin
                    state <= 1;  // Transition to first byte state
                end
            end
            1: begin  // First byte state
                if (reset_fedge) begin
                    state <= 1;  // Stay in the first byte state on reset deassertion
                end else begin
                    state <= 2;  // Transition to second byte state
                end
            end
            2: begin  // Second byte state
                if (reset_fedge) begin
                    state <= 1;  // Transition back to first byte state on reset deassertion
                end else begin
                    state <= 3;  // Transition to third byte state
                end
            end
            3: begin  // Third byte state
                if (reset_fedge) begin
                    state <= 1;  // Transition back to first byte state on reset deassertion
                end else begin
                    state <= 0;  // Transition back to idle state
                end
            end
        endcase
    end
end

assign done = (state == 3);

endmodule
