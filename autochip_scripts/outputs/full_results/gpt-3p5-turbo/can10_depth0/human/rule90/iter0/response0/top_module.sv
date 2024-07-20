module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    // Internal wire for storing the updated state of the cells
    wire [511:0] next_q;
    
    // Sequential block for updating the state of the cells
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end
    
    // Combinational block for calculating the next state of the cells
    generate
        genvar i;
        for (i = 0; i < 512; i = i + 1) begin
            assign next_q[i] = calculate_next_state(q, i);
        end
    endgenerate
    
    // Function for calculating the next state of a cell based on its neighbors' states
    function [0:1] calculate_next_state(input [511:0] current_state, input [9:0] index);
        // Extract the states of the neighboring cells
        reg [2:0] left_cell = current_state[index - 1];
        reg [2:0] center_cell = current_state[index];
        reg [2:0] right_cell = current_state[index + 1];
        
        // Calculate the next state by applying the Rule 90 rules
        reg [2:0] next_state;
        case ({left_cell, center_cell, right_cell})
            3'b111: next_state = 3'b000;
            3'b110: next_state = 3'b001;
            3'b101: next_state = 3'b010;
            3'b100: next_state = 3'b011;
            3'b011: next_state = 3'b100;
            3'b010: next_state = 3'b101;
            3'b001: next_state = 3'b110;
            3'b000: next_state = 3'b111;
        endcase
        
        // Return the calculated next state
        calculate_next_state = next_state;
    endfunction
    
endmodule
