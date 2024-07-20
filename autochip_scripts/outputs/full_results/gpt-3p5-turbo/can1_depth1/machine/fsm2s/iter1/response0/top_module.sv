module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    
    reg state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
        end else begin
            state <= next_state;
        end
        
        case (state)
            0: begin
                if (j) begin
                    next_state <= 1;
                end else begin
                    next_state <= 0;
                end
            end
            1: begin
                if (k) begin
                    next_state <= 0;
                end else begin
                    next_state <= 1;
                end
            end
            default: next_state <= 0;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end else begin
            if (state == 1) begin
                out <= 1;
            end else begin
                out <= 0;
            end
        end
    end
      
endmodule
