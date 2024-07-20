module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    wire next_state_high;
    
    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 4'b0000;
        else
            state <= next_state_high ? state + 1 : 4'b0000;
    end
    
    always @(*) begin
        case (state)
            0: next_state_high = data;
            1: next_state_high = data;
            2: next_state_high = data;
            3: next_state_high = data;
            default: next_state_high = 1'b0;
        endcase
    end
    
    assign start_shifting = (state == 4'b0111);
  
endmodule
