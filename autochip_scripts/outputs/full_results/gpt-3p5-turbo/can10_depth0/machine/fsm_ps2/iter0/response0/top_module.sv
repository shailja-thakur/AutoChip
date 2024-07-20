module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [7:0] state;
    reg done_signal;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 8'b0000_0001;  // BYTE1 state
            done_signal <= 0;
        end else begin
            case (state)
                8'b0000_0001:  // BYTE1 state
                    if (in[2] == 1'b1)
                        state <= 8'b0000_0010;  // BYTE2 state
                    else
                        state <= 8'b0000_0001;  // Stay in BYTE1 state
                8'b0000_0010:  // BYTE2 state
                    state <= 8'b0000_0100;  // BYTE3 state
                8'b0000_0100:  // BYTE3 state
                    state <= 8'b0000_1000;  // DONE state
                8'b0000_1000:  // DONE state
                    if (in[2] == 1'b1)
                        state <= 8'b0000_0010;  // Transition to BYTE2 state
                    else
                        state <= 8'b0000_0001;  // Transition to BYTE1 state
            endcase
        end
    end

    always @(state) begin
        if (state == 8'b0000_1000)  // DONE state
            done_signal <= 1'b1;
        else
            done_signal <= 1'b0;
    end

    assign done = done_signal;

endmodule
