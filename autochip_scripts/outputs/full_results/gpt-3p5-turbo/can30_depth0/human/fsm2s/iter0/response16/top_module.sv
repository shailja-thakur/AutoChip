module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state;
    parameter OFF = 2'b00;
    parameter ON = 2'b01;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            case (state)
                OFF: begin
                    if (j) begin
                        state <= ON;
                    end
                end
                
                ON: begin
                    if (k) begin
                        state <= OFF;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
         case (state)
            OFF: out <= 1'b0;
            ON: out <= 1'b1;
        endcase      
    end

endmodule
