module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;
    
    parameter OFF = 2'b00;
    parameter ON = 2'b01;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            
            ON: begin
                if (k)
                    next_state = OFF;
                else 
                    next_state = ON;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else begin
            case (state)
                OFF: out <= 0;
                ON: out <= 1;
            endcase
        end
    end
    
endmodule
