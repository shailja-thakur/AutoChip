module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    
    reg [1:0] state;
    reg prev_reset;
    
    always @(posedge clk) begin
        if (reset && !prev_reset)
            state <= 2'b00;  // Reset state OFF
        else begin
            case (state)
                2'b00: begin  // OFF state
                    if (j)
                        state <= 2'b01;  // Transition to ON state
                    else
                        state <= 2'b00;  // Remain in OFF state
                end
                2'b01: begin  // ON state
                    if (k)
                        state <= 2'b00;  // Transition to OFF state
                    else
                        state <= 2'b01;  // Remain in ON state
                end
            endcase
        end
        prev_reset <= reset;
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
