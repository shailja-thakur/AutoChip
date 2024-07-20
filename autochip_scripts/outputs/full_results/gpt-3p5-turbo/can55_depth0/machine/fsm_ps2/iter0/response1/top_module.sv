module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
reg [1:0] state;
reg done_reg;
wire check_bit;

assign check_bit = in[2];

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // Initialize state to BYTE1
    end else begin
        case(state)
            2'b00: begin // BYTE1 state
                if (check_bit) begin
                    state <= 2'b01; // Transition to BYTE2 state
                end
            end
            2'b01: begin // BYTE2 state
                state <= 2'b10; // Transition to BYTE3 state
            end
            2'b10: begin // BYTE3 state
                state <= 2'b11; // Transition to DONE state
            end
            2'b11: begin // DONE state
                if (check_bit) begin
                    state <= 2'b01; // Transition to BYTE2 state
                end else begin
                    state <= 2'b00; // Transition to BYTE1 state
                end
            end
            default: begin
                state <= 2'b00; // Default case, transition to BYTE1 state
            end
        endcase
    end
end

always @(state) begin
    done_reg = (state == 2'b11); // Assert done signal when in DONE state
end

assign done = done_reg;

endmodule
