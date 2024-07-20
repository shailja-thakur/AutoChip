module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            state <= 2'b0;
        end else begin
            case (state)
                2'b00: begin // OFF state
                    if (j == 1'b0) begin
                        state <= 2'b00; // Stay in OFF state
                    end else if (j == 1'b1) begin
                        state <= 2'b01; // Transition to ON state
                    end
                end
                2'b01: begin // ON state
                    if (k == 1'b0) begin
                        state <= 2'b01; // Stay in ON state
                    end else if (k == 1'b1) begin
                        state <= 2'b00; // Transition to OFF state
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: begin // OFF state
                out <= 1'b0;
            end
            2'b01: begin // ON state
                out <= 1'b1;
            end
        endcase
    end
    
endmodule
