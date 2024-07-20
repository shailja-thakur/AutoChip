module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state, next_state;
    reg out_reg;
    
    parameter OFF = 2'b0;
    parameter ON = 2'b1;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next_state;
    end
    
    always @* begin
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
            default: begin
                next_state = OFF;
            end
        endcase
    end

    always @(posedge clk) begin
        if (areset)
            out_reg <= 1'b0;
        else begin
            case (state)
                OFF: out_reg <= 1'b0;
                ON: out_reg <= 1'b1;
            endcase
        end
    end

    assign out = out_reg;

endmodule
