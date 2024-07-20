module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// State register
reg [1:0] state;
// Next state register
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
    if (~resetn)
        state <= 2'b00; // Set state to A when reset is low
    else
        state <= next_state; // Update state
    
    // Logic for next state
    case (state)
        2'b00: // State A
            if (r[1])
                next_state = 2'b01; // Next state is B if r[1] is high
            else if (r[2])
                next_state = 2'b10; // Next state is C if r[2] is high
            else if (r[3])
                next_state = 2'b11; // Next state is D if r[3] is high
            else
                next_state = 2'b00; // Next state is A if none of the bits of r are high
        2'b01: // State B
            if (r[1])
                next_state = 2'b01; // Next state is B if r[1] is high
            else
                next_state = 2'b00; // Next state is A if r[1] is low
        2'b10: // State C
            if (r[2])
                next_state = 2'b10; // Next state is C if r[2] is high
            else
                next_state = 2'b00; // Next state is A if r[2] is low
        2'b11: // State D
            if (r[3])
                next_state = 2'b11; // Next state is D if r[3] is high
            else
                next_state = 2'b00; // Next state is A if r[3] is low
    endcase
end

// Assign output vector g based on current state
assign g[1] = (state == 2'b01) ? 1'b1 : 1'b0; // g[1] is high if current state is B
assign g[2] = (state == 2'b10) ? 1'b1 : 1'b0; // g[2] is high if current state is C
assign g[3] = (state == 2'b11) ? 1'b1 : 1'b0; // g[3] is high if current state is D

endmodule
