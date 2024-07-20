module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    
    reg [1:0] state;
    reg out_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00; // OFF state
            out_reg <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // OFF state
                    if (j) state <= 2'b01; // Transition to ON state
                    else state <= 2'b00;
                    out_reg <= 1'b0;
                end
                2'b01: begin // ON state
                    if (k) state <= 2'b00; // Transition to OFF state
                    else state <= 2'b01;
                    out_reg <= 1'b1;
                end
                default: begin
                    state <= 2'b00; // Default to OFF state
                    out_reg <= 1'b0;
                end
            endcase
        end
    end
    
    assign out = out_reg;
    
endmodule
