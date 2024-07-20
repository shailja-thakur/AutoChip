module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state;
    end
    
    always @(state or data) begin
        next_state = state;
        case (state)
            4'b0000: begin // Initial State
                if (data)
                    next_state = 4'b0001;
            end
            
            4'b0001: begin // State 1
                if (data)
                    next_state = 4'b0010;
                else
                    next_state = 4'b0000;
            end
            
            4'b0010: begin // State 2
                if (data)
                    next_state = 4'b0011;
                else
                    next_state = 4'b0000;
            end
            
            4'b0011: begin // State 3
                if (data)
                    next_state = 4'b0100;
                else
                    next_state = 4'b0000;
            end
            
            4'b0100: begin // State 4 (Sequence Found)
                next_state = 4'b0100;
                start_shifting = 1;
            end 
        endcase
    end
    
endmodule
