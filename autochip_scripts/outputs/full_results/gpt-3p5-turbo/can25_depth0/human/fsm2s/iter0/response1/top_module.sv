module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    // Define the states
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    // Define the state register
    reg [1:0] state;
    
    // Define the output register
    reg out_reg;
    
    // Assign output reg to output
    assign out = out_reg;
    
    // Synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
            out_reg <= 1'b0;
        end else begin
            case(state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                        out_reg <= 1'b1;
                    end
                end
                ON: begin
                    if (!k) begin
                        state <= ON;
                    end else begin
                        state <= OFF;
                        out_reg <= 1'b0;
                    end
                end
            endcase
        end
    end
endmodule
