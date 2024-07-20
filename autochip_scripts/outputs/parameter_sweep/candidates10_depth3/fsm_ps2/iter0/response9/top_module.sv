module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [1:0] state;
    reg [7:0] byte1, byte2, byte3;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00; // initialize to initial state
            byte1 <= 8'b0;
            byte2 <= 8'b0;
            byte3 <= 8'b0;
        end
        else begin
            case (state)
                2'b00: begin // IDLE state
                    if (in[3] == 1'b1) begin
                        byte1 <= in;
                        state <= 2'b01; // transition to middle state
                    end
                end
                2'b01: begin // MIDDLE state
                    byte2 <= in;
                    state <= 2'b10; // transition to final state
                end
                2'b10: begin // FINAL state
                    byte3 <= in;
                    state <= 2'b00; // transition back to IDLE state
                end
                default: state <= 2'b00; // reset to IDLE state if unknown state
            endcase
        end
    end
    
    assign done = (state == 2'b10);
endmodule
