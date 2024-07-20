module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state; // define state as a 3-bit register
reg [7:0] in_reg; // register to store the input byte
reg [1:0] counter; // add counter to track the number of bytes received

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 0; // reset the state to initial state
    else begin
        case (state)
            0: begin // State 0: Discard bytes until in[3]=1
                if (in[3] == 1) begin
                    state <= 1; // Move to State 1
                    counter <= 0; // Reset the counter
                    in_reg <= in; // Store the input byte
                end else begin
                    state <= 0; // Stay in State 0
                end
            end
            1: begin // State 1: Waiting for byte 2
                state <= 2; // Move to State 2
                in_reg <= in; // Store the input byte
            end
            2: begin // State 2: Waiting for byte 3
                if (in[3] == 1) begin
                    state <= 0; // Move back to State 0
                    counter <= 0; // Reset the counter
                    in_reg <= in; // Store the input byte
                    done <= 1; // Signal the receipt of a message
                end else if (counter == 1) begin
                    state <= 0; // Move back to State 0
                    counter <= 0; // Reset the counter
                    in_reg <= in; // Store the input byte
                end else begin
                    state <= 1; // Move back to State 1
                    counter <= 1; // Increment the counter
                    in_reg <= in; // Store the input byte
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset)
        done <= 0;
    else if (state == 2 && in_reg != in)
        done <= 0;
end

endmodule
