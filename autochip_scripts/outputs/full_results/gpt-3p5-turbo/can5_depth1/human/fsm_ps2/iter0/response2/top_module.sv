module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    reg [7:0] in_reg;
    reg [2:0] state;
    reg done_reg;
    
    // State definitions
    parameter S_IDLE = 0;
    parameter S_BYTE1 = 1;
    parameter S_BYTE2 = 2;
    parameter S_BYTE3 = 3;
    
    always @(posedge clk) begin
        
        if (reset) begin
            state <= S_IDLE;
            done_reg <= 0;
        end else begin
            case (state)
                S_IDLE: begin
                    if (in[3] == 1) begin
                        state <= S_BYTE1;
                    end
                end
                
                S_BYTE1: begin
                    state <= S_BYTE2;
                end
                
                S_BYTE2: begin
                    state <= S_BYTE3;
                end
                
                S_BYTE3: begin
                    state <= S_IDLE;
                    done_reg <= 1;
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            in_reg <= 0;
        end else begin
            in_reg <= in;
        end
    end
    
    assign done = done_reg;
    
endmodule
