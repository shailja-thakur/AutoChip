module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // Start in the BYTE1 state
        end else begin
            case(state)
                2'b00: begin // BYTE1 state
                    if (in[2] == 1'b1) begin
                        state <= 2'b01; // Transition to the BYTE2 state
                    end
                end
                2'b01: begin // BYTE2 state
                    state <= 2'b10; // Transition to the BYTE3 state
                end
                2'b10: begin // BYTE3 state
                    state <= 2'b11; // Transition to the DONE state
                end
                2'b11: begin // DONE state
                    if (in[2] == 1'b0) begin
                        state <= 2'b00; // Transition back to the BYTE1 state
                    end else begin
                        state <= 2'b01; // Transition back to the BYTE2 state
                    end
                end
            endcase
        end
    end
    
    assign done = (state == 2'b11);
    
endmodule
