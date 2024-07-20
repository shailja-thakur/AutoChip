module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] first_byte;
reg [7:0] second_byte;
reg [7:0] third_byte;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin  // Idle state
                if (in[3] == 1) begin
                    state <= 1;  // Transition to first byte state
                    first_byte <= in;
                end
            end
            1: begin  // First byte state
                state <= 2;  // Transition to second byte state
                second_byte <= in;
            end
            2: begin  // Second byte state
                state <= 3;  // Transition to third byte state
                third_byte <= in;
            end
            3: begin  // Third byte state
                state <= 0;  // Transition back to idle state
                if (in[3] == 1) begin
                    done <= 1;  // Signal receipt of a message
                end
            end
        endcase
    end
end

assign done = 0;

endmodule
