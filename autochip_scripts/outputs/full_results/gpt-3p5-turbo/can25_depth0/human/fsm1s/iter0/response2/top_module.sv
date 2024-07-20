module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                2'b00: begin // State B
                    if (in == 0) begin
                        state <= 2'b01; // Transition to State A
                    end else begin
                        state <= 2'b00; // Remain in State B
                    end
                end
                2'b01: begin // State A
                    if (in == 0) begin
                        state <= 2'b00; // Transition to State B
                    end else begin
                        state <= 2'b01; // Remain in State A
                    end
                end
            endcase
        end
    end
    
    assign out = (state == 2'b00) ? 1 : 0;
    
endmodule
