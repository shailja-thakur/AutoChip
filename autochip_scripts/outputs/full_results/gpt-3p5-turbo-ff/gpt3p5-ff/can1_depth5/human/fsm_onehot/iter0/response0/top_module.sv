module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    // Declare internal wires
    wire [9:0] next_state_temp;
    wire [9:0] state_reg;
    wire [1:0] output_reg;
    
    // Implement the state transition logic
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
    
    // Implement the output logic
    assign output_reg[0] = (state[5] & ~in) | (state[7] & in);
    assign output_reg[1] = state[6] & in;
    
    // Synchronize the state and output registers
    always @(posedge clk) begin
        state_reg <= state;
        output_reg <= output_reg;
    end
    
    // Assign the synchronized state and output registers as outputs
    assign next_state = next_state_temp;
    assign out1 = output_reg[0];
    assign out2 = output_reg[1];

endmodule
