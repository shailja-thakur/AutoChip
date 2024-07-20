module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter STATE_A = 1'b0;
    parameter STATE_B = 1'b1;
    
    reg state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= STATE_B; // Reset the state to STATE_B
        end
        else begin
            case (state)
                STATE_A: begin
                    if (in) begin
                        state <= STATE_A; // Remain in STATE_A if in is high
                    end
                    else begin
                        state <= STATE_B; // Transition to STATE_B if in is low
                    end
                end
                STATE_B: begin
                    if (in) begin
                        state <= STATE_B; // Remain in STATE_B if in is high
                    end
                    else begin
                        state <= STATE_A; // Transition to STATE_A if in is low
                    end
                end
            endcase
        end
    end
    
    assign out = (state == STATE_B); // Output is high when in STATE_B, low otherwise

endmodule
