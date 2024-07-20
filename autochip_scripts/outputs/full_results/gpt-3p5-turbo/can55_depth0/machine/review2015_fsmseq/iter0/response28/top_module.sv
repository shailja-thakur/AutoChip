module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [2:0] state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if(reset)
            state <= 3'b000;
        else
            state <= next_state;
    end
    
    always @(*) begin
        next_state = state;
        
        case(state)
            3'b000: if(data) next_state = 3'b001; else next_state = 3'b000;
            3'b001: if(data) next_state = 3'b011; else next_state = 3'b000;
            3'b011: if(data) next_state = 3'b011; else next_state = 3'b010;
            3'b010: if(data) next_state = 3'b111; else next_state = 3'b000;
            3'b111: next_state = 3'b111;
        endcase
    end
    
    assign start_shifting = (state == 3'b111);
    
endmodule
