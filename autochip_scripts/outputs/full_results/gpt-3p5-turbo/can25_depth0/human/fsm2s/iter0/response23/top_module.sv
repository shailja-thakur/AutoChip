module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    enum {OFF, ON} state;
    reg [1:0] nextState;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= nextState;
        end
    end
    
    always @(state or j or k) begin
        case (state)
            OFF: begin
                if (j) begin
                    nextState = ON;
                end else begin
                    nextState = OFF;
                end
                out = 0;
            end
            ON: begin
                if (k) begin
                    nextState = OFF;
                end else begin
                    nextState = ON;
                end
                out = 1;
            end
            default: nextState = OFF;
        endcase
    end
    
endmodule
