module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    
    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // OFF state
        end else begin
            case (state)
                2'b00: begin // OFF state
                    if (j) begin
                        state <= 2'b01; // Transition to ON state
                    end else begin
                        state <= 2'b00; // Remain in OFF state
                    end
                end
                2'b01: begin // ON state
                    if (k) begin
                        state <= 2'b00; // Transition to OFF state
                    end else begin
                        state <= 2'b01; // Remain in ON state
                    end
                end
                default: begin
                    state <= 2'b00; // Default state is OFF
                end
            endcase
        end
    end
    
    assign out = (state == 2'b01) ? 1'b1 : 1'b0;
    
endmodule
