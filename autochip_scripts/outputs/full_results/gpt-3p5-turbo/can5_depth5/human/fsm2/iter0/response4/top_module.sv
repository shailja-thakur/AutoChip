module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    reg state;
    reg next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 0;
        else
            state <= next_state;
    end
    
    always @(state or j or k) begin
        case (state)
            0: begin // OFF
                if (j)
                    next_state = 1; // ON
                else
                    next_state = 0; // OFF
                out = 0;
            end
            1: begin // ON
                if (k)
                    next_state = 0; // OFF
                else
                    next_state = 1; // ON
                out = 1;
            end
            default: begin
                next_state = 0; // OFF
                out = 0;
            end
        endcase
    end
endmodule
