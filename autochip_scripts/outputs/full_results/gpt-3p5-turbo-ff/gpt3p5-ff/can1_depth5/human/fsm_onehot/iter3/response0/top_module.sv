module top_module (
    input in,
    input wire clk,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    wire [9:0] next_state_temp;
    reg [9:0] state_reg;
    reg [1:0] output_reg;
    
    always @(posedge clk) begin
        state_reg <= state;
        output_reg <= output_reg;
    end
    
    assign next_state_temp[0] = state[0] & ~in;
    assign next_state_temp[1] = state[0] & in;
    assign next_state_temp[2] = state[1] & ~in;
    assign next_state_temp[3] = state[1] & in;
    assign next_state_temp[4] = state[2] & ~in;
    assign next_state_temp[5] = state[2] & in;
    assign next_state_temp[6] = state[3] & ~in;
    assign next_state_temp[7] = state[3] & in;
    assign next_state_temp[8] = state[4] & ~in;
    assign next_state_temp[9] = state[4] & in;
    
    always @(posedge clk) begin
        next_state <= next_state_temp;
        out1 <= (state_reg[5] & ~in) | (state_reg[7] & in);
        out2 <= state_reg[6] & in;
    end
    
endmodule
