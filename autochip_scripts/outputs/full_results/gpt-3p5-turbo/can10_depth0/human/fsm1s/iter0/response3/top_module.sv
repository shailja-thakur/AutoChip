module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b10; // B state
        end else begin
            case(state)
                2'b10: begin // B state
                    if (in) begin
                        state <= 2'b10; // Stay in B state
                    end else begin
                        state <= 2'b01; // Transition to A state
                    end
                end
                2'b01: begin // A state
                    if (in) begin
                        state <= 2'b01; // Stay in A state
                    end else begin
                        state <= 2'b10; // Transition to B state
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b0 : 1'b1; // Output 0 when in A state, 1 otherwise

endmodule
