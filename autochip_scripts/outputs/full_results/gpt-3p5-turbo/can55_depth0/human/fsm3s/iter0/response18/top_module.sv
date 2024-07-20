module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    reg [1:0] state;
    reg out_reg;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 2'b00; // reset to state A
            out_reg <= 1'b0;
        end
        else begin
            case(state)
                2'b00: begin // State A
                    if(in)
                        state <= 2'b01; // Next state in = 1, go to state B
                    else
                        state <= 2'b00; // Next state in = 0, stay in state A
                        
                    out_reg <= 1'b0;
                end

                2'b01: begin // State B
                    if(in)
                        state <= 2'b01; // Next state in = 1, stay in state B
                    else
                        state <= 2'b10; // Next state in = 0, go to state C
                        
                    out_reg <= 1'b0;
                end

                2'b10: begin // State C
                    if(in)
                        state <= 2'b11; // Next state in = 1, go to state D
                    else
                        state <= 2'b00; // Next state in = 0, go to state A
                        
                    out_reg <= 1'b0;
                end

                2'b11: begin // State D
                    if(in)
                        state <= 2'b10; // Next state in = 1, go to state B
                    else
                        state <= 2'b10; // Next state in = 0, stay in state D
                        
                    out_reg <= 1'b1;
                end
            endcase
        end
    end

    assign out = out_reg;

endmodule
