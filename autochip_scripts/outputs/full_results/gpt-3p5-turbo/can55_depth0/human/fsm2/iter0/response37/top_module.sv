module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    reg [1:0] state;
    reg out_reg;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 0; // reset to state OFF
        else begin
            case (state)
                2'b00: begin // OFF state
                    if (j) 
                        state <= 2'b01; // transition to ON state if j is high
                    else
                        state <= 2'b00; // stay in OFF state if j is low
                end
                    
                2'b01: begin // ON state
                    if (k)
                        state <= 2'b00; // transition to OFF state if k is high
                    else
                        state <= 2'b01; // stay in ON state if k is low
                end
            endcase
        end
    end

    always @(posedge clk)
        case (state)
            2'b00: out_reg <= 1'b0; // OFF state, output is low
            2'b01: out_reg <= 1'b1; // ON state, output is high
        endcase
    
    assign out = out_reg;
    
endmodule
