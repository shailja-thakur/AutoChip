module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    reg [1:0] state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b0; // Reset to state OFF
        else begin
            case(state)
                2'b00: begin // State OFF
                    if (j)
                        state <= 2'b01; // Transition to state ON
                    else
                        state <= 2'b00; // Remain in state OFF
                end
                2'b01: begin // State ON
                    if (k)
                        state <= 2'b00; // Transition to state OFF
                    else
                        state <= 2'b01; // Remain in state ON
                end
                default: state <= 2'b0; // Reset to state OFF if no conditions match
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
